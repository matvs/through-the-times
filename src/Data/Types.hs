{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilyDependencies #-}

module Data.Types where

import Data.List.NonEmpty
import Data.Map (Map)
import Data.Map.Strict qualified as M
import Data.Set (Set)
import Data.Set qualified as S




data Age = A | I | II | III deriving (Show)

newtype PlayerId = PlayerId Int
  deriving (Eq, Ord, Show)

data Player = Player
  { name :: String,
    civ :: Civilization
  } deriving (Show)

data GameState = GameState
  { players :: Map PlayerId Player,
    turnOrder :: [PlayerId],
    age :: Age
  } deriving (Show)

data Civilization = Civilization
  { cards :: [Card],
    buildings :: [Building],
    technologies :: Set Technology,
    resources :: Resources,
    government :: Government,
    leader :: Maybe Leader
  }
  deriving (Show)

-- Gameplay
data ResourceCard = Breakthrough | Reserves deriving (Show)

data Politics = Polish deriving (Show)

data Card = LeaderCard Leader | ResourceCard ResourceCard | TechnologyCard Technology | PoliticalCard Politics deriving (Show)

data Leader = Mati deriving (Show)

data Building = Mine deriving (Show, Enum, Bounded)

data BuildingDef = BuildingDef
  { cost :: Resources,
    produces :: Resources,
    bonus :: Resources,
    requires :: Set Technology
  }

data Technology = Wheel | LabTechnology | MineTechnology | TempleTechnology deriving (Show, Eq, Ord)

data Government = Despot deriving (Show)

data ResourceType = Food | Ore | Science | Culture | Worker | Strength | Population | Happiness | CivilActionToken | PopBank deriving (Show, Eq, Ord)

newtype Resources = Resources (M.Map ResourceType Integer) deriving Show

instance Semigroup Resources where
  (Resources a) <> (Resources b) = Resources (M.unionWith (+) a b)
instance Monoid Resources where
    mempty  = Resources M.empty
    mconcat = foldl' (<>) mempty

