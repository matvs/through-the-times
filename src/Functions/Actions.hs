module Functions.Actions where

import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.Set as S
import Data.Types
import Functions.Resources
import Functions.Building
import Functions.Civilization

data ActionError = NotEnoughResources 

data AnyAction where
  AnyGameplay :: Action 'GameplayAction -> AnyAction 
  AnyGame :: Action 'GameAction -> AnyAction 

instance Show AnyAction where
    show (AnyGameplay (Build b)) = "Build " ++ show b
    show (AnyGame Revert) = "Undo action"
    show (AnyGame EndPhase) = "End turn"

allBuildings :: [Building]
allBuildings = [minBound..]

availableBuildings :: Civilization -> [Action GameplayAction]
availableBuildings c = 
    map Build . filter (\b -> requires b `S.isSubsetOf` technologies c) $ allBuildings


defaultActions :: [AnyAction]
defaultActions = fmap AnyGame [Revert, EndPhase]


availableActions :: GameState 'Action -> [AnyAction]
availableActions (ActionState (c:|_)) = fmap AnyGameplay (availableBuildings c) ++ defaultActions



data Outcome = ActionError String | Success (GameState 'Action)


tryAction :: GameState 'Action -> Action 'GameplayAction -> Outcome
tryAction s@(ActionState (c:|cs)) (Build b) =
    case spend c b of
        Nothing -> ActionError "Not enough resources."
        Just newC -> Success (ActionState (newC:|cs))
tryAction a _ = Success a