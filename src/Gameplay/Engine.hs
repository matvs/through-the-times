module Gameplay.Engine where

import Data.Types
import Gameplay.Rule


data Command = Command
data EngineMode = EngineMode

data Engine = Engine {
  gameState :: GameState,
  engineMode :: EngineMode
}


runEngine = runRule (RuleContext{activePlayer = PlayerId 1}) newGameState (build Mine) 