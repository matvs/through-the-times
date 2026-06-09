module Gameplay.Engine where


import Data.Types
import Data.List.NonEmpty
import Functions.Civilization
import Functions.Actions
import Gameplay.Phase
import Prelude hiding (tail, head)

-- NextPhase is a type level function that enforces the state transition.
handleGameState :: GameState a -> IO (GameState (NextPhase a))
handleGameState (PoliticsState cs) = pure (ActionState cs)
handleGameState p@(ActionState cs) = actionPhase [] p
handleGameState p@(ProductionState _) = pure (productionPhase p)
handleGameState (CleanUpState (c:|cs)) = pure (PoliticsState (prependList cs (c:|[])))
    

startGame :: GameStatus 'Politics
startGame = Started (PoliticsState (createCivilization "Jan" :| [createCivilization "Mati"]))