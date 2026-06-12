module UI.Loop where

import Data.Types
import Functions.Civilization
import Gameplay.Engine
import Text.Read (readMaybe)


loop = do
     putStrLn "Welcome to Through the Times (not to be confused with another game)"
     loop'

playerInput :: IO Engine
playerInput = undefined

loop' = do
    putStrLn "Ready to start a game? (Y/n)"
    input <- getLine
    if input == "Y" then
        playerInput
    else
            loop'
