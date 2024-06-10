module Main (main) where

import Elections (generateURLs, processURLs)

main :: IO ()
main = do
  let outputFilePath = "election_results.csv"
      errorFilePath = "err.csv"
  processURLs generateURLs outputFilePath errorFilePath
