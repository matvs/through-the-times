module Gameplay.Engine where


import Data.Types
import Data.List.NonEmpty
import Functions.Civilization
import Functions.Actions
import Gameplay.Phase
import Prelude hiding (tail, head)

-- NextPhase is a type level function that enforces the state transition.
finishState :: GameState a -> GameState (NextPhase a)
finishState (PoliticsState cs) = ActionState cs
finishState (ActionState cs) = ProductionState cs
finishState p@(ProductionState _) = productionPhase p
finishState p@(CleanUpState _) = cleanUpPhase p
    

startGame :: GameStatus 'Politics
startGame = Started (PoliticsState (createCivilization "Jan" :| [createCivilization "Mati"]))

data Response = ChooseAction [AnyAction] | ActionResult (GameState 'Action) (GameState 'Action) | WrongInput | Undo | Done 
newtype Request = ChosenAction AnyAction 


actionPhase :: GameState 'Action -> Response
actionPhase as = ChooseAction (availableActions as)


chooseAction :: GameState 'Action -> Request -> Response
chooseAction as (ChosenAction (AnyGame EndPhase)) = Done
chooseAction as (ChosenAction (AnyGame Revert)) = Undo
chooseAction as (ChosenAction (AnyGameplay action)) =
    case tryAction as action of
      Success newState -> do
        ActionResult as newState
      ActionError s -> WrongInput