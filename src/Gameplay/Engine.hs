{-# LANGUAGE OverloadedRecordDot #-}

module Gameplay.Engine where

import Data.Types
import Data.List.NonEmpty 
import Prelude hiding (head)
import Gameplay.Rule


data Command = Command
data EngineMode
  = AwaitingAction PlayerId
  | PoliticsPhase PlayerId
  | ProductionPhase PlayerId
  | CleanupPhase PlayerId
  | Finished

data Engine = Engine { gameState :: GameState, mode :: EngineMode }

runRuleM = runRule (RuleContext{activePlayer = PlayerId 1}) newGameState (build Mine) 

data Request = Action | GameOver

data EngineOutput = EngineOutput {
  events :: [Event],
  request :: Request
}

nextTurn pId engine = nextTurn' engine.gameState.turnOrder
  where nextTurn' (x :| []) = head engine.gameState.turnOrder
        nextTurn' (x :| (y : xs)) = if pId == x then y else nextTurn' (y :| xs)

runEngine Engine {mode = Finished } = EngineOutput{events = [], request = GameOver}