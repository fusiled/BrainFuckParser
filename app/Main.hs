module Main where

import BrainFuckPublic

main :: IO ()
main = do
  putStrLn $ show( runBrainFuckString "+++[->+<]" )
