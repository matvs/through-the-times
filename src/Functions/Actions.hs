module Functions.Actions where

import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.Set as S
import Data.Types
import Functions.Resources
import Functions.Building
import Functions.Civilization

data ActionError = NotEnoughResources 

allBuildings :: [Building]
allBuildings = [minBound..]

availableBuildings :: Civilization -> [Action GameplayAction]
availableBuildings c = 
    map Build . filter (\b -> requires b `S.isSubsetOf` technologies c) $ allBuildings


defaultActions :: [Action GameAction]
defaultActions = [Revert, EndPhase]

availableActions :: GameState 'Action -> [Either (Action GameplayAction) (Action GameAction)]
availableActions (ActionState (c:|_)) = map Left (availableBuildings c) ++ map Right defaultActions



data Outcome = ActionError String | Success (GameState 'Action)


tryAction :: GameState 'Action -> Action 'GameplayAction -> Outcome
tryAction s@(ActionState (c:|cs)) (Build b) =
    case spend c b of
        Nothing -> ActionError "Not enough resources."
        Just newC -> Success (ActionState (newC:|cs))
tryAction a _ = Success a