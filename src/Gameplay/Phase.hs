module Gameplay.Phase where

import Data.List.NonEmpty (NonEmpty (..))
import Data.Map.Strict qualified as M
import Data.Types
import Functions.Actions
import Functions.Civilization
import Text.Read (readMaybe)

productionPhase :: GameState 'Production -> GameState 'CleanUp
productionPhase (ProductionState (c :| cs)) =
  CleanUpState (c {resources = M.unionWith (+) (resources c) (production c)} :| cs)
