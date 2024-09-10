module QueueTests where

import TestingFramework
import Queue

test_empty :: [(String,IO TestResult)]
test_empty = do
    [("emptyBasic",testEqual empty ([],[]))]

test_dequeueEmpty :: [(String,IO TestResult)]
test_dequeueEmpty =
    [("dequeueEmptyBasic",testEqual (dequeue empty) (0,([],[])))]

test_enqueueDequeue :: [(String,IO TestResult)]
test_enqueueDequeue =
    [("enqueueDequeueBasic0",testEqual (nthQueueElement 0 (enqueueList [1,2,3,4] empty)) 1)
    ,("enqueueDequeueBasic1",testEqual (nthQueueElement 2 (enqueueList [1,2,3,4] empty)) 3)
    ,("enqueueDequeueBasic2",testEqual (nthQueueElement 4 (enqueueList [1,2,3,4] empty)) 0)
    ,("enqueueDequeueBasic3",testEqual (nthQueueElement 3 (enqueueList [1,2,3,4] empty)) 4) 
    ]
    where
        enqueueList []  q = q 
        enqueueList (h:t) q = enqueueList t (enqueue q h)
        nthQueueElement 0 q = fst (dequeue q)
        nthQueueElement n q = nthQueueElement (n-1) (snd (dequeue q))

test_multiQAndD :: [(String,IO TestResult)]
test_multiQAndD =
    [("multi1",testEqual (fst $ dequeue (snd $ dequeue (enqueue (snd $ dequeue (enqueue (enqueue empty 1) 2)) 4))) 4)
    ,("multi2",testEqual (fst $ dequeue (enqueue (snd $ dequeue (enqueue (enqueue empty 1) 2)) 4)) 2)]
    where
        enqueueList []  q = q 
        enqueueList (h:t) q = enqueueList t (enqueue q h)
        nthQueueElement 0 q = fst (dequeue q)
        nthQueueElement n q = nthQueueElement (n-1) (snd (dequeue q))

allTests :: TestSuite
allTests = test_empty ++ test_dequeueEmpty ++ test_enqueueDequeue ++ test_multiQAndD