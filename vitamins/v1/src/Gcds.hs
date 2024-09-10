module Gcds
    ( isDivisor,
      allDivisors,
      listIntersection,
      listGcd
    ) where

{-
  First you should implement divisors. isDivisor a b should return true exactly
  when there exists some integer k such that a * k = b. A way to quickly check
  this is by determining whether b % a == 0. In Haskell the mod function is
  just a function: mod. The code: "mod a b" returns the same as most languages
  "a % b", or what is commonly known in English as "a mod b"

  Once you've implemented isDivisor, test it! We have provided a benchmark
  suite of a few tests to check your code with. However, this benchmark suite
  is non-exhaustive. Try adding some of your own!
-}
isDivisor :: Int -> Int -> Bool
isDivisor a b = mod b a == 0

{-
  Next, given a number, we want to get all divisors from that number. We want
  those numbers returned from largest to smallest. For example, given the
  number 8, allDivisors would return [8,4,2,1].
-}
allDivisors :: Int -> [Int]
allDivisors num = reverse [x | x <- [1..num], isDivisor x num]

{-
  Almost done! Now we would like to figure out the intersection of two lists.
  In listIntersection, you can assume that the incoming lists are ordered from
  largest to smallest. You should output a list also ordered from largest to
  smallest. For example, if you intersect the same list with itself, you should
  get that list back!
-}
listIntersection :: [Int] -> [Int] -> [Int]
listIntersection _ [] = []
listIntersection [] _ = []
listIntersection list1 list2 = filter (`elem` list1) list2

{-
  Last bit! From here, you can find a list of all common divisors by
  intersecting the list of a's divisors with the list of b's divisors. This
  list should be ordered from largest to smallest, so you just need to extract
  the first from it!
-}
listGcd :: Int -> Int -> Int
listGcd a b = head (listIntersection (allDivisors a) (allDivisors b))
  


