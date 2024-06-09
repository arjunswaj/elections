module Main (main) where

import Elections (processURLs)

main :: IO ()
main = do
  let urls = ["https://results.eci.gov.in/PcResultGenJune2024/ConstituencywiseS138.htm", 
              "https://results.eci.gov.in/PcResultGenJune2024/ConstituencywiseS139.htm"]
      outputFilePath = "election_results.csv"
  processURLs urls outputFilePath
