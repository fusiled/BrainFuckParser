module BrainFuckPublic where


import BrainFuckCommon
import BrainFuckParser as P
import BrainFuckTranslator as T
import BrainFuckSimulator as S 


runBrainFuckString :: String -> Maybe Context
runBrainFuckString str = S.simulate $ T.translate $ P.parse  str