module UI.Loop where

import Data.Types
import Functions.Civilization
import Gameplay.Engine
import Text.Read (readMaybe)

loop :: IO ()
loop = do
  putStrLn "Welcome to the game of through the times (do not confuse with through the ages)"
  loop' NotStarted

loop' :: GameStatus a -> IO ()
loop' NotStarted = do
  putStrLn "Hej, do you wanna play a game? (Y/n)"
  answer <- getLine
  case answer of
    "Y" -> loop' startGame
    _ -> loop' NotStarted
loop' Finished = do
  putStrLn "And the winner is Jan"
loop' (Started gs) = gameLoop gs

actionLoop :: GameState 'Action -> IO ()
actionLoop a = actionLoop' (actionPhase a) a []

actionLoop' :: Response -> GameState 'Action -> [GameState 'Action] -> IO ()
actionLoop' (ChooseAction as) gs past = do
    print gs
    let actions = zip [1 ..] as
    mapM_ print actions
    pick <- getLine
    case readMaybe pick >>= (`lookup` actions) of
      Nothing -> do
        putStrLn "Invalid action"
        actionLoop' (ChooseAction as) gs past
      Just action -> do
        print action
        actionLoop' (chooseAction gs (ChosenAction action)) gs past
actionLoop' (ActionResult old new) _ past = do
  putStrLn "You built it!"
  actionLoop' (actionPhase new) new (old:past)
-- Should undo exist on the UI level? Probably not.
actionLoop' Undo a [] = do
  putStrLn "Can't undo anymore"
  actionLoop' (actionPhase a) a []
actionLoop' Undo a (p:past) = do
  putStrLn "Undoing last action"
  actionLoop' (actionPhase p) p past
actionLoop' WrongInput p past = do
  putStrLn "Impossible !"
  actionLoop' (actionPhase p) p past
actionLoop' Done gs past = gameLoop (finishState gs)


gameLoop :: GameState a -> IO ()
gameLoop a@(ActionState _) = actionLoop a
gameLoop gs = do
  print gs
  answer <- getLine
  case answer of
    "EXIT" -> loop' Finished
    _ -> do gameLoop (finishState gs)