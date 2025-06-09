-- Pascal's Triangle
-- source used to help me: https://stackoverflow.com/questions/27233133/pascal-triangle-in-haskell
pascal :: Int -> [Int]
pascal 0 = [1]
pascal n = zipWith (+) (0 : pascal (n-1)) (pascal (n-1) ++ [0])

-- Pointfree Addition
addPair :: (Int,Int) -> Int
addPair = uncurry (+)

-- Pointfree Filtering
withoutZeros :: (Eq a, Num a) => [a] -> [a]
withoutZeros = filter (/= 0)

-- Searching? Maybe?
findElt :: Eq a => a -> [a] -> Maybe Int
findElt x list = search 0 list
  where
    -- start at index 0, then search through the list
    -- if the element is found, return its index wrapped in Just    
    -- otherwise return Nothing
    search _ []     = Nothing
    search i (y:ys)
      | x == y    = Just i
      | otherwise = search(i + 1) ys
