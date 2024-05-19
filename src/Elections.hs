module Elections (processURLs) where

import CSV.CSVWriter (writeCSV)
import Network.HTTPClient (fetchWebPage)
import Parser.HTMLParser (extractTableRows)

processURLs :: [String] -> FilePath -> IO ()
processURLs urls csvFilePath = do
  allRows <- mapM fetchAndParse urls
  let combinedRows = concatMap (\(url, rows) -> map (\row -> url : row) rows) allRows
  writeCSV csvFilePath combinedRows
  where
    fetchAndParse url = do
      html <- fetchWebPage url
      let rows = extractTableRows html
      return (url, rows)
