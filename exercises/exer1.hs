det a b c = b^2 - 4*a*c
quadsol1 a b c = (-b - sqrt (det a b c))/2*a
quadsol2 a b c = (-b + sqrt (det a b c))/2*a

-- writing your first code
third_a list = list !! 2
third_b (_:_:x:_) = x

-- factorial
fact 0 = 1
fact n = n * fact (n - 1)

-- hailstone function
hailstone n
    | even n = n `div` 2
    | otherwise = 3 * n + 1

-- hailstone length
hailLen n
    | n == 1 = 0
    | otherwise = 1 + hailLen (hailstone n)
