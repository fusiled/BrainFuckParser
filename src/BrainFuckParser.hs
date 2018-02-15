module BrainFuckParser where

import BrainFuckCommon

import Control.Monad
import System.IO
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Expr
import Text.ParserCombinators.Parsec.Language
import qualified Text.ParserCombinators.Parsec.Token as Token


languageDef =
  emptyDef {Token.reservedNames = [">", "<", "+", "-", ".", ",", "[", "]"]}

lexer = Token.makeTokenParser languageDef

reserved = Token.reserved lexer -- parses an operator

whiteSpace = Token.whiteSpace lexer -- parses whitespace

brainFuckParser :: Parser Stmt
brainFuckParser = whiteSpace >> statement

-- We use <|> to express choice. So a <|> b will first try parser a
-- and if it fails (but without actually consuming any input) then parser b
-- will be used. Note: this means that the order is important. 
statement :: Parser Stmt
statement = do
  list <- (many1 statementCore)
  return $ Seq list

statementCore :: Parser Stmt
statementCore = inc <|> dec <|> add <|> sub <|> out <|> inp <|> loop

loop :: Parser Stmt
loop = do
  reserved "["
  body <- statement
  reserved "]"
  return $ Seq [body]

inc :: Parser Stmt
inc = do
  reserved ">"
  return Inc

dec :: Parser Stmt
dec = do
  reserved "<"
  return Dec

add :: Parser Stmt
add = do
  reserved "+"
  return Add

sub :: Parser Stmt
sub = do
  reserved "-"
  return Sub

out :: Parser Stmt
out = do
  reserved "."
  return Sub

inp :: Parser Stmt
inp = do
  reserved ","
  return Sub

parse :: String -> Stmt
parse str =
  case Text.ParserCombinators.Parsec.parse brainFuckParser "" str of
    Left e -> error $ show e
    Right bfSeq -> bfSeq


