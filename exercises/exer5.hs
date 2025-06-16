import Data.Ratio

-- Built-In Functions
myIterate :: (a -> a) -> a -> [a]
myIterate f x = x : myIterate f (f x)

mySplitAt :: Int -> [a] -> ([a], [a])
mySplitAt 0 xs     = ([], xs) -- if n is 0, return empty list and the original list
mySplitAt _ []     = ([], []) -- if the list is empty, return two empty lists
mySplitAt n (x:xs) = (x : word1, word2)
    where
        (word1, word2) = mySplitAt (n - 1) xs

-- Rational Nunbers
rationalSum :: Int -> [Ratio Int]
rationalSum n = [ x % y | x <- [1 .. n], y <- [1 .. n], x + y == n]

-- Lowest Terms Only
rationalSumLowest :: Int -> [Ratio Int]
rationalSumLowest n = [ x % y | x <- [1 .. n], y <- [1 .. n], x + y == n, gcd x y == 1]

-- All Rational Numbers
rationals :: [Ratio Int]
rationals = concatMap rationalSumLowest [1 ..]

-- Input/Output
-- split a list around a given separator value
splitAtSeparator :: Eq a => a -> [a] -> [[a]]
splitAtSeparator sep [] = []
splitAtSeparator sep content = first : splitAtSeparator sep rest
    where
    first = takeWhile (/= sep) content
    firstlen = length first
    rest = drop (firstlen+1) content

-- convert an integer-like string to an integer
readInt :: String -> Int
readInt = read

sumFile :: IO ()
sumFile = do
    fileData <- readFile "input.txt"
    let textLines = splitAtSeparator '\n' fileData -- split the file content into lines
        numbers = map readInt textLines -- convert string to int
        acc = sum numbers -- sum the numbers
    print acc