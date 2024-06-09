module Elections (processURLs) where

import CSV.CSVWriter (writeCSV)
import Control.Exception (SomeException, try)
import qualified Control.Monad as CM
import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import Network.HTTPClient (fetchWebPage, FetchException (..))
import Parser.HTMLParser (extractTableRows)
import System.Directory (doesFileExist, removeFile)
import System.IO
    ( Handle, IOMode(AppendMode), hPutStrLn, withFile )

processURLs :: [String] -> FilePath -> FilePath -> IO ()
processURLs urls csvFilePath errorFilePath = do
  -- Delete the CSV and error files if they exist
  removeIfExists csvFilePath
  removeIfExists errorFilePath
  -- Open CSV file in append mode
  withFile csvFilePath AppendMode $ \csvHandle -> do
    -- Open error file in append mode
    withFile errorFilePath AppendMode $ \errorHandle -> do
      -- Process each URL one by one
      mapM_ (processURL csvHandle errorHandle) (zip [1..] urls )
  where
    removeIfExists :: FilePath -> IO ()
    removeIfExists filePath = do
      fileExists <- doesFileExist filePath
      CM.when fileExists $ removeFile filePath

    processURL :: Handle -> Handle -> (Integer, String) -> IO ()
    processURL csvHandle errorHandle pair = do
      let num = show $ fst pair
      let url = snd pair
      putStrLn $ num ++ ". Processing " ++ url
      result <- try (fetchAndParse url) :: IO (Either FetchException [[String]])
      case result of
        Left (FetchException code err) -> hPutStrLn errorHandle $ formatCSVRow ["Missing", show code, url]
        Right [] -> hPutStrLn errorHandle $ formatCSVRow ["No rows present", "0", url]
        Right (x:xs) -> mapM_ (hPutStrLn csvHandle . formatCSVRow) (x:xs)

    fetchAndParse :: String -> IO [[String]]
    fetchAndParse url = do
      html <- fetchWebPage url
      let rows = fromMaybe [] (extractTableRows html)
      return rows

    formatCSVRow :: [String] -> String
    formatCSVRow = intercalate ","
