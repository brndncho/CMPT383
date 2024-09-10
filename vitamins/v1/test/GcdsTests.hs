module GcdsTests where

import TestingFramework
import Gcds

test_isDivisor :: [(String,IO TestResult)]
test_isDivisor =
  [("isDivisorBasic0",testEqual (isDivisor 2 4) True)
  ,("isDivisorBasic1",testEqual (isDivisor 4 2) False)
  ]

test_allDivisors :: [(String,IO TestResult)]
test_allDivisors =
  [("allDivisorsBasic0",testEqual (allDivisors 2) [2,1])
  ,("allDivisorsBasic1",testEqual (allDivisors 6) [6,3,2,1])
  ]

test_listIntersection :: [(String,IO TestResult)]
test_listIntersection =
  [("listIntersectionBasic0",testEqual (listIntersection [2,1] [1]) [1])
  ,("listIntersectionBasic1",testEqual (listIntersection [2,1] [2]) [2])
  ]

test_listGcd :: [(String,IO TestResult)]
test_listGcd =
  [("listGcdBasic0",testEqual (listGcd 3 6) 3)
  ,("listGcdBasic1",testEqual (listGcd 12 8) 4)
  ,("listGcdBasic2",testEqual (listGcd 1 9) 1)
  ]

allTests :: TestSuite
allTests = test_isDivisor ++ test_allDivisors ++ test_listIntersection ++ test_listGcd