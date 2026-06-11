module Gameplay.Phase where

import Data.List.NonEmpty (NonEmpty (..), prependList)
import Data.Map.Strict qualified as M
import Data.Types
import Functions.Actions
import Functions.Civilization
import Text.Read (readMaybe)

productionPhase :: GameState 'Production -> GameState 'CleanUp
productionPhase (ProductionState (c :| cs)) =
  CleanUpState (c {resources = M.unionWith (+) (resources c) (production c)} :| cs)


cleanUpPhase :: GameState 'CleanUp -> GameState 'Politics
cleanUpPhase (CleanUpState (c :| cs))= 
    let newCiv = civilTokens c in
    PoliticsState (prependList cs (newCiv:|[]))