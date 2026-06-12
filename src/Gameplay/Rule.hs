{-# LANGUAGE OverloadedRecordDot #-}
module Gameplay.Rule where

import Data.Types
import Data.Map
import Control.Monad.Trans.Reader (ReaderT (runReaderT), ask)
import Control.Monad.Trans.State (StateT (runStateT), get, modify)
import Control.Monad.Trans.Writer (WriterT (runWriterT), tell)
import Data.Set (Set)
import qualified Data.Map as M
import qualified Data.Set as S
import Control.Monad.Trans.Class (lift)
import Control.Monad
import Functions.Building
import Functions.Resources

newtype RuleContext = RuleContext {activePlayer :: PlayerId}

data GameError = InsufficientResources Resources | MissingTechnologies (Set Technology) | PlayerNotFound | Unknown

data Event = ResourcesSpent Resources | BuildingBuilt Building

type RuleM =
  ReaderT
    RuleContext
    (StateT GameState (WriterT [Event] (Either GameError)))
    
runRule :: RuleContext -> GameState -> RuleM a -> Either GameError (a, GameState, [Event])
runRule ctx gs rule = do
  ((a, gs'), events) <- runWriterT (runStateT (runReaderT rule ctx) gs)
  pure (a, gs', events)


getPlayer :: RuleM Player
getPlayer = do
    RuleContext pId <- ask
    gs <- lift get

    case M.lookup pId gs.players of
        Nothing     -> failRule PlayerNotFound
        Just player -> pure player

getCiv :: RuleM Civilization
getCiv = do
    p <- getPlayer 
    pure p.civ

getResources :: RuleM Resources
getResources = do
    civ <- getCiv
    pure civ.resources

failRule :: GameError -> RuleM a
failRule err =
  lift . lift . lift $ Left err

emit :: Event -> RuleM ()
emit e = lift . lift $ tell [e]

hasTechPrerequisite :: Building -> RuleM Bool
hasTechPrerequisite building = do
    civ <- getCiv
    pure ((buildingDef building).requires `S.isSubsetOf` civ.technologies)

updatePlayer :: (Player -> Player) -> RuleM ()
updatePlayer f = do
    RuleContext pId <- ask
    lift $ modify (\gs -> gs {players = M.adjust f pId (players gs)})

updateCivilization :: (Civilization -> Civilization) -> RuleM ()
updateCivilization f = updatePlayer (\player -> player {civ = f (civ player)})
    

spendResources :: Resources -> RuleM ()
spendResources cost = do
    emit (ResourcesSpent cost)
    updateCivilization (\civ -> civ {resources = civ.resources `minus` cost})


addBuilding :: Building -> RuleM ()
addBuilding building = do
    _ <- spendResources (buildingDef building).cost
    emit (BuildingBuilt building)
    updateCivilization (\civ -> civ {buildings = building:civ.buildings})

build :: Building -> RuleM ()
build building = do
    let def = buildingDef building

    resources <- getResources
    hasTechPrerequisite <- hasTechPrerequisite building

    unless hasTechPrerequisite $
        failRule (MissingTechnologies def.requires)

    unless (canAfford resources def.cost) $
        failRule (InsufficientResources def.cost)

    addBuilding building
