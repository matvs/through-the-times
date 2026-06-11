{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilyDependencies #-}

module Data.Types where

import qualified Data.Set as S
import qualified Data.Map.Strict as M
import Data.List.NonEmpty

data ResourceCard = Breakthrough | Reserves deriving Show
data Politics = Polish deriving Show
data Card = LeaderCard Leader | ResourceCard ResourceCard | TechnologyCard Technology | PoliticalCard Politics deriving Show

data Leader = Mati deriving Show

data Building = Mine | Lab | Temple deriving (Show, Enum, Bounded)
data Technology = Wheel | LabTechnology | MineTechnology | TempleTechnology deriving (Show, Eq, Ord)
data Government = Despot deriving Show
data ResourceType = Food | Ore | Science | Culture | Worker 
                  | Strength | Population | Happiness | CivilActionToken | PopBank deriving (Show, Eq, Ord)
type Resources = M.Map ResourceType Integer

data Civilization = Civilization {
    name :: String,
    cards :: [Card],
    buildings :: [Building],
    technologies :: S.Set Technology,
    resources :: Resources,
    government :: Government,
    leader :: Maybe Leader
} deriving Show

data GameStatus a = NotStarted | Finished | Started (GameState a) deriving Show

data Phase = Politics | Action | Production | CleanUp | EndGame deriving (Enum, Show, Eq)

type family NextPhase p where
  NextPhase 'Politics = 'Action
  NextPhase 'Action = 'Production
  NextPhase 'Production = 'CleanUp
  NextPhase 'CleanUp = 'Politics

data GameState (a :: Phase) where
  PoliticsState :: NonEmpty Civilization -> GameState 'Politics
  ActionState :: NonEmpty Civilization -> GameState 'Action
  ProductionState :: NonEmpty Civilization -> GameState 'Production
  CleanUpState :: NonEmpty Civilization -> GameState 'CleanUp  

instance Show (GameState a) where
  show (PoliticsState civs)    = "PoliticsState " ++ show civs
  show (ActionState civs)      = "ActionState " ++ show civs
  show (ProductionState civs)  = "ProductionState " ++ show civs
  show (CleanUpState civs)     = "CleanUpState " ++ show civs


data ActionType = GameAction | GameplayAction deriving Show

data Action (a :: ActionType) where 
  IncreasePop :: Action 'GameplayAction
  Destroy :: Building -> Action 'GameplayAction
  Build :: Building -> Action 'GameplayAction
  Take :: Card -> Action 'GameplayAction
  Play :: Card -> Action 'GameplayAction
  Revert :: Action 'GameAction
  EndPhase :: Action 'GameAction 
  
instance Show (Action a) where
  show :: Action a -> String
  show IncreasePop      = "Increase Pop"
  show (Destroy b)      = "Destroy " ++ show b
  show (Build b)        = "Build " ++ show b
  show (Take card)      = "Take " ++ show card
  show (Play card)      = "Play " ++ show card
  show Revert           = "Revert"
  show EndPhase         = "EndPhase"


