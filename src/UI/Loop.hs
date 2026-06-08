module UI.Loop where

import Gameplay.Engine
import Functions.Civilization
import Data.Types

loop :: GameState -> IO ()
loop NotStarted = do 
  putStrLn "Hej, do you wanna play a game? (Y/n)"
  answer <- getLine
  case answer of
    "Y" -> loop (GameState [createCivilization "Jan", createCivilization "Mati"] Action) 
    _ -> loop NotStarted

loop Finished = do 
  putStrLn "And the winner is Jan"
loop x@(GameState civilizations phase) = do
  putStrLn ("Current Player " ++ show (head civilizations))
  putStrLn (show phase)
  answer <- getLine
  case answer of
    "EXIT" -> loop Finished
    _ -> loop (handleGameState x)


