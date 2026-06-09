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

actionPhase :: [GameState 'Action] -> GameState 'Action -> IO (GameState 'Production)
actionPhase prevStates as@(ActionState (c :| cs)) = do
  let actions = zip [1 ..] (availableActions as)
  mapM_ print actions

  pick <- getLine
  case readMaybe @Int pick >>= (`lookup` actions) of
    Nothing -> do
      putStrLn "Invalid action"
      actionPhase prevStates as
    Just action -> handleAction action
  where
    handleAction (Right Revert) = case prevStates of
      prevState : _ -> actionPhase (drop 1 prevStates) prevState
      [] -> do
        putStrLn "You haven't taken any actions!"
        actionPhase [] as
    handleAction (Right EndPhase) =
      pure $ ProductionState (c :| cs)
    handleAction (Left ac) = case tryAction as ac of
      Success newState -> do
        print newState
        actionPhase (as : prevStates) newState
      ActionError s -> do
        putStrLn ("Oh no! " ++ s)
        actionPhase prevStates as