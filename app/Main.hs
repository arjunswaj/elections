module Main (main) where

import Elections (processURLs)

main :: IO ()
main = do
  let urls = ["https://results.eci.gov.in/AcResultByeJan2024/ConstituencywiseS203.htm", "https://results.eci.gov.in/AcResultByeJan2024/ConstituencywiseS203.htm"]
      outputFilePath = "election_results.csv"
  processURLs urls outputFilePath
