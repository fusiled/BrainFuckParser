module BrainFuckCommon where
-- export everything

import Data.Word8 as W8


data Stmt
  = Seq [Stmt] -- A program is a sequence of statements A loop is a program withing brackets [  ]
  | Inc -- >   Increment the pointer
  | Dec -- <   Decrement the pointer
  | Add -- +   Increment the byte at the pointer
  | Sub -- -   Decrement the byte at the pointer
  | Out -- .   Output the byte at the pointer
  | Inp -- ,   Input a byte and store it in the byte at the pointer
  deriving (Show)

-- helper. Apply to the passed monad all the functions contained in the array (the second argument)

bindToList :: (Monad m) => m a -> [a -> m a] -> m a
bindToList _ [] = undefined
bindToList partial [f] = partial >>= f
bindToList partial (f:fs) =
  let newPartial = partial >>= f
  in bindToList newPartial fs

type Byte = W8.Word8

-- the context used by the simulator
data Context = Context { index :: Int         
                       , tape  :: [W8.Word8]
                       , inputString :: String
                       , outputString :: String 
                       } deriving (Show)

emptyContext :: Context
emptyContext = Context {index=0, tape=replicate 10 0 , inputString="", outputString=""}


getContext :: String -> Context
getContext passedInput = Context {index=0, tape=replicate 10 0 , inputString=passedInput, outputString=""}