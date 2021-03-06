{-# language NumericUnderscores #-}

import Gauge.Main (defaultMain,bgroup,bench,whnf)
import Data.Word (Word64)
import System.Random (mkStdGen,uniformR)
import Data.List (unfoldr)

import qualified Data.Masstree.BTree as BTree
import qualified Data.Map.Strict as Map

main :: IO ()
main = defaultMain
  [ bgroup "btree"
    [ bench "fromList-20000" $ whnf BTree.fromList pairs20000
    , bench "fromList-150000" $ whnf BTree.fromList pairs150000
    ]
  , bgroup "containers"
    [ bench "fromList-20000" $ whnf Map.fromList pairs20000
    , bench "fromList-150000" $ whnf Map.fromList pairs150000
    ]
  ]

pairs20000 :: [(Word64,())]
{-# noinline pairs20000 #-} 
pairs20000 = map
  (\x -> (x,()))
  (take 20000 (unfoldr (Just . uniformR (0, 1_000_000_000)) (mkStdGen 9652364)))

pairs150000 :: [(Word64,())]
{-# noinline pairs150000 #-} 
pairs150000 = map
  (\x -> (x,()))
  (take 150000 (unfoldr (Just . uniformR (0, 1_000_000_000)) (mkStdGen 24627637)))
