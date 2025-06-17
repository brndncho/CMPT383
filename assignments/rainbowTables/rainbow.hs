{-# LANGUAGE ScopedTypeVariables #-}
-- rainbow.hs
-- Implements pwReduce, rainbowTable, and findPassword for Rainbow Tables assignment

module Rainbow where

import RainbowAssign          -- provides pwHash, toLetter, Hash, Passwd
import qualified Data.Map as Map
import Data.Map (Map)
import Data.Int                -- for Int32 type
import Data.Maybe (listToMaybe)

-- User-defined parameters (adjust as needed)
pwLength, nLetters, width, height :: Int
pwLength = 8            -- length of each password
nLetters = 5            -- number of letters to use in passwords: 5 -> a-e
width    = 40           -- length of each chain in the table
height   = 1000         -- number of chains (rows) in the table

filename :: FilePath
filename = "table.txt"  -- filename to store/read the table

-- pwReduce: convert a Hash value back into a possible Passwd of length pwLength
pwReduce :: Hash -> Passwd
pwReduce h = map toLetter digitsMS
  where
    -- convert Int32 hash to Int for arithmetic
    h' :: Int
    h' = fromIntegral h
    -- generate infinite list of base-nLetters digits (least-significant first)
    digitsLE :: [Int]
    digitsLE = gen h'
      where
        gen x
          | x > 0     = let (q, r) = x `divMod` nLetters in r : gen q
          | otherwise = repeat 0
    -- take pwLength least-significant digits, then reverse to most-significant first
    digitsMS = reverse $ take pwLength digitsLE

-- rainbowTable: given chain width and initial passwords, map final Hash to initial Passwd
type RainbowTable = Map Hash Passwd

rainbowTable :: Int -> [Passwd] -> RainbowTable
rainbowTable w pws = Map.fromList [ (chainEnd pw, pw) | pw <- pws ]
  where
    -- compute final Hash after w iterations of hash->reduce->...->hash
    chainEnd :: Passwd -> Hash
    chainEnd pw0 = iterateChain w pw0

    iterateChain :: Int -> Passwd -> Hash
    iterateChain 0 pw    = pwHash pw
    iterateChain k pw    = let h   = pwHash pw
                               pw' = pwReduce h
                           in iterateChain (k - 1) pw'

-- findPassword: attempt to reverse a target Hash using the rainbow table
findPassword :: RainbowTable -> Int -> Hash -> Maybe Passwd
findPassword table w target = listToMaybe matches
  where
    -- try each offset i from 0..w: reconstruct possible chain endpoints
    matches = concatMap tryOffset [0..w]

    tryOffset :: Int -> [Passwd]
    tryOffset i =
      let candidateEnd = advance i target
      in case Map.lookup candidateEnd table of
           Nothing  -> []
           Just pw0 -> case crackChain pw0 of
                         Nothing  -> []
                         Just pw' -> [pw']

    -- advance the target hash forward i steps: apply reduce->hash i times
    advance :: Int -> Hash -> Hash
    advance 0 h0 = h0
    advance k h0 = advance (k - 1) (pwHash (pwReduce h0))

    -- given an initial password, walk its chain up to w steps looking for target
    crackChain :: Passwd -> Maybe Passwd
    crackChain pw0 = go pw0 0
      where
        go pw i
          | i > w               = Nothing
          | pwHash pw == target = Just pw
          | otherwise           = go (pwReduce (pwHash pw)) (i + 1)

-- Example routines for table generation and testing:

-- generateTable: build a random table and write to file
generateTable :: IO ()
generateTable = do
  table <- buildTable rainbowTable nLetters pwLength width height
  writeTable table filename

-- test2: attempt to crack n random passwords, returning successes and count
test2 :: Int -> IO ([Passwd], Int)
test2 n = do
  table <- readTable filename
  pws <- randomPasswords nLetters pwLength n
  let hs = map pwHash pws
  let result = Maybe.mapMaybe (findPassword table width) hs
  return (result, length result)

-- You can compile and run with:
-- ghc -O2 --make rainbow.hs
-- main function (if desired):
-- main :: IO ()
-- main = do
--   generateTable
--   res <- test2 10000
--   print res
