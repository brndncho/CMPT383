divisors :: Int -> [Int]
divisors n = [i | i <- [2..(n `div` 2)], n `mod` i == 0]
primes :: Int -> [Int]
primes n = [i | i <- [2..n], divisors i == [] ]

pythagorean :: Int -> [(Int, Int, Int)]
pythagorean n = [(a, b, c) | a <- [1..n], b <- [1..n], a < b, c <- [1..n], b < c, a^2 + b^2 == c^2]

join :: String -> [String] -> String
join sep [] = ""
join sep [x] = x
join sep (x:xs) = x ++ sep ++ join sep xs

fact' :: Int -> Int
fact' n = foldl (*) 1 [1..n]

hailstone :: Int -> Int
hailstone n
    | even n = n `div` 2
    | otherwise = 3 * n + 1

hailLen :: Int -> Int
hailLen n = hailTail 0 n
  where
    hailTail a 1 = a
    hailTail a n = hailTail (a + 1) (hailstone n)