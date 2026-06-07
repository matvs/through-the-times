module Gameplay.Phase where

import qualified Data.Map.Strict as M

import Data.Types
import Functions.Civilization

executePhase :: Phase -> Civilization -> Civilization
executePhase Production c = c { resources = M.unionWith (+) (resources c) (production c)}
executePhase _ c = c
