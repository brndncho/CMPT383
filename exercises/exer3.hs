-- date/time modules
import Data.Time.Calendar
import Data.Time.Calendar.OrdinalDate

-- merging
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    -- if x is less than y, then x comes first in the merged list and vice versa
    | x < y     = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

-- merge sort
mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort lst = merge (mergeSort left) (mergeSort right) -- merging the two halves
    where
        mid   = length lst `div` 2 -- midpoint
        left  = take mid lst -- left half of the list
        right = drop mid lst -- right half of the list

-- haskell library and dates

-- daysInYear function
daysInYear :: Integer -> [Day]
daysInYear y = [jan1 .. dec31]
    where
        jan1  = (fromGregorian y 1 1)
        dec31 = (fromGregorian y 12 31)

-- isFriday function
isFriday :: Day -> Bool
isFriday d = snd (mondayStartWeek d) == 5

-- helper functions
divisors :: Int -> [Int]
divisors n = [i | i <- [2..(n `div` 2)], n `mod` i == 0]

getDay (y, m, d) = d

-- isPrimeDay function
isPrimeDay :: Day -> Bool
isPrimeDay primeD = 
    let d = getDay (toGregorian primeD)
        divs = divisors d
    in d > 1 && null divs

-- primeFridays function
primeFridays :: Integer -> [Day]
primeFridays y =
  [ d | d <- daysInYear y, isFriday d, isPrimeDay d ]