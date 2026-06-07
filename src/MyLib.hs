module MyLib where
import qualified Data.Map.Strict as M
someFunc :: IO ()
someFunc = putStrLn "someFunc"

type Resources = M.Map ResourceType Integer
data Civilization = Civilization {
    name :: String,
    buildings :: [Building],
    technologies :: [Technology],
    resources :: Resources
} deriving Show
createCivilization :: String -> Civilization 
createCivilization name = Civilization {name, buildings = [Mine, Mine, Mine], technologies = [], resources = M.empty }

-- class Building a where
--     produce :: Resources
--     bonus :: Resources

produceResources :: ResourceType -> Integer -> Resources
produceResources = M.singleton

data Technology = Wheel deriving Show
produce :: Building -> Resources
produce Mine = produceResources Ore 1
produce _ = M.empty
data Building = Mine deriving Show

bonus :: Building -> Resources
bonus Mine = M.singleton Science 5

data ActionType = Military | Civil deriving (Show, Eq, Ord)
data ResourceType = Food | Ore | Science | Culture | Worker 
                  | Strength | Population | ActionToken ActionType deriving (Show, Eq, Ord)

data Player = Player

data Phase = Action | Production | CleanUp deriving (Enum, Show)

production :: Civilization -> Resources
-- function composition 
production = M.unionsWith (+) . map produce . buildings



executePhase :: Phase -> Civilization -> Civilization
executePhase Production c = c { resources = M.unionWith (+) (resources c) (production c)}
executePhase _ c = c

data GameState = NotStarted | Finished | GameState [Civilization] Phase 

handleGameState :: GameState -> GameState
handleGameState (GameState (c:cs) phase) =
    let c' = executePhase phase c
    in
        case phase of
             CleanUp -> GameState (cs ++ [c']) Action
             _ -> GameState (c':cs) (succ phase)






