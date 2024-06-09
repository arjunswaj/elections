module Main (main) where

import Elections (processURLs)

main :: IO ()
main = do
  let urls = ["https://results.eci.gov.in/PcResultGenJune2024/ConstituencywiseS138.htm", 
              "https://results.eci.gov.in/PcResultGenJune2024/ConstituencywiseS139.htm",
              "https://results.eci.gov.in/PcResultGenJune2024/ConstituencywiseS159.htm",
              "https://example.com"]
      outputFilePath = "election_results.csv"
      errorFilePath = "err.csv"
  processURLs urls outputFilePath errorFilePath
