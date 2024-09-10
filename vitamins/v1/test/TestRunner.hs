module Main ( main ) where

import qualified GcdsTests
import qualified QueueTests

import TestingFramework

allTests :: TestSuite
allTests = GcdsTests.allTests ++ QueueTests.allTests

main :: IO ()
main = do
    v2 <- runTestsFeedback allTests
    putStrLn v2