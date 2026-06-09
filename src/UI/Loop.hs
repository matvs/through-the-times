module UI.Loop where

import Gameplay.Engine
import Functions.Civilization
import Data.Types

loop :: IO ()
loop =  do
  putStrLn "Welcome to the game of through the times (do not confuse with through the ages)"
  loop' NotStarted
  where
    loop' :: GameStatus a -> IO ()
    loop' NotStarted = do
      putStrLn "Hej, do you wanna play a game? (Y/n)"
      answer <- getLine
      case answer of
        "Y" -> loop' startGame
        _ -> loop' NotStarted
    loop' Finished = do 
      putStrLn "And the winner is Jan"
    loop' (Started gs) = do
      print gs
      answer <- getLine
      case answer of
        "EXIT" -> loop' Finished
        _ -> do
          gs <- handleGameState gs
          loop' (Started gs)