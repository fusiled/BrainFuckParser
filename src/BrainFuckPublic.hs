module BrainFuckPublic
( runBrainFuckString
)  where

import BrainFuckCommon
import BrainFuckParser as P
import BrainFuckTranslator as T
import BrainFuckSimulator as S 


runBrainFuckString :: String -> String -> Maybe Context
runBrainFuckString src inputString = 
  let 
    parsedAndTranslatedResult= T.translate $ P.parse src
  in
    S.simulate inputString parsedAndTranslatedResult