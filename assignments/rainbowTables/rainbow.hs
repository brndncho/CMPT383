-- imports
module Rainbow where

import RainbowAssign 
import qualified Data.Map as Map
import Data.Maybe
import Data.List()

-- paramenters
pwLength, nLetters, width, height :: Int
filename :: FilePath
pwLength = 5            -- length of each password
nLetters = 18            -- number of letters to use in passwords: 5 -> a-e
width = 60              -- length of each chain in the table
height = 800           -- number of "rows" in the table
filename = "table.txt"  -- filename to store the table

-- pwReduce
pwReduce :: Hash -> Passwd
pwReduce h = map toLetter ( reverse ( take pwLength ( digits ++ repeat 0 ))) -- take pwLength LSD
  where
    -- convert from int32 to int
    digits :: [Int]
    digits = toDigits (fromEnum h)

    -- convert to base nLetters
    toDigits :: Int -> [Int]
    toDigits 0 = []
    toDigits x = let r = x `mod` nLetters
                     q = x `div` nLetters
                 in r : toDigits q

-- rainbowTable: given chain width and initial passwords, map final Hash to initial Passwd
type RainbowTable = Map.Map Hash Passwd

-- helper for hashing and reducing step
hashAndReduce :: Hash -> Hash
hashAndReduce = pwHash . pwReduce

rainbowTable :: Int -> [Passwd] -> RainbowTable
rainbowTable w initPassword =
  Map.fromList
    [ (iterate hashAndReduce (pwHash pw0) !! w, pw0)
    | pw0 <- initPassword
    ]

-- findPassword: attempt to reverse a target Hash using the rainbow table
findPassword :: RainbowTable -> Int -> Hash -> Maybe Passwd 
findPassword table w hash = go 0
  where
    go :: Int -> Maybe Passwd
    go offset
      | offset == w = Nothing -- stop if we reached all possible positions
      | otherwise =
          let h = iterate hashAndReduce hash !! offset
          in case Map.lookup h table of
               Nothing -> go ( offset + 1 ) -- no chain ends with hash h, continue searching
               Just p0 -> -- if we found a starting password p0
                 let stepsToTarget = w - offset -- how many steps to reach the target hash
                     pwdCandidate = iterate (pwReduce . pwHash) p0 !! stepsToTarget -- keep reducing until we reach the target hash
                 in if pwHash pwdCandidate == hash
                       then Just pwdCandidate -- found a match
                       else go ( offset + 1 ) -- continue searching


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
  let result = Data.Maybe.mapMaybe (findPassword table width) hs
  return (result, length result)
