module Data.Types where

import qualified Data.Map.Strict as M

data Technology = Wheel deriving Show
data Building = Mine | Lab | Temple deriving Show
data ActionType = Military | Civil deriving (Show, Eq, Ord)
data ResourceType = Food | Ore | Science | Culture | Worker 
                  | Strength | Population | Happiness | ActionToken ActionType deriving (Show, Eq, Ord)
type Resources = M.Map ResourceType Integer

data Civilization = Civilization {
    name :: String,
    buildings :: [Building],
    technologies :: [Technology],
    resources :: Resources
} deriving Show

data Phase = Action | Production | CleanUp deriving (Enum, Show)
data GameState = NotStarted | Finished | GameState [Civilization] Phase 