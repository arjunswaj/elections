module Elections (processURLs) where

import CSV.CSVWriter (writeCSV)
import Network.HTTPClient (fetchWebPage)
import Parser.HTMLParser (extractTableRows)
import Data.Maybe (fromMaybe)

processURLs :: [String] -> FilePath -> IO ()
processURLs urls csvFilePath = do
  allRows <- mapM fetchAndParse urls
  let combinedRows = concat allRows
  writeCSV csvFilePath combinedRows
  where
    fetchAndParse url = do
      html <- fetchWebPage url
      let rows = fromMaybe [] (extractTableRows html)
      return rows
