module Gameplay.Engine where

import Gameplay.Phase
import Data.Types
import Functions.Civilization

handleGameState :: GameState -> GameState
handleGameState (GameState (c:cs) phase) =
    let c' = executePhase phase c
    in
        case phase of
             CleanUp -> GameState (cs ++ [c']) Action
             _ -> GameState (c':cs) (succ phase)

