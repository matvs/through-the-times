module Main where

import  MyLib

main :: IO ()
main = do
  putStrLn "Welcome to the game of through the times (do not confuse with through the ages)"
  run NotStarted


run :: GameState -> IO ()
run NotStarted = do 
  putStrLn "Hej, do you wanna play a game? (Y/n)"
  answer <- getLine
  case answer of
    "Y" -> run (GameState [createCivilization "Jan", createCivilization "Mati"] Action) 
    _ -> run NotStarted

run Finished = do 
  putStrLn "And the winner is Jan"
run x@(GameState civilizations phase) = do
  putStrLn ("Current Player " ++ show (head civilizations))
  putStrLn (show phase)
  answer <- getLine
  case answer of
    "EXIT" -> run Finished
    _ -> run (handleGameState x)


