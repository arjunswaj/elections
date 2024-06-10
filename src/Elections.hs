module Elections (processURLs, generateURLs, Constituency (..)) where

import CSV.CSVWriter (writeCSV)
import Control.Exception (SomeException, try)
import Control.Monad (foldM_)
import qualified Control.Monad as CM
import Data.Char (toUpper)
import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import Demography.StateDetails
  ( StateDetail,
    generateStateDetails,
  )
import Network.HTTPClient (FetchException (..))
import qualified Network.HTTPClient as HC
import Parser.HTMLParser (constituencyNameFetcher, extractTableRows)
import System.Directory (doesFileExist, removeFile)
import System.IO
  ( Handle,
    IOMode (AppendMode),
    hPutStrLn,
    withFile,
  )

data Constituency = Constituency
  { code :: String,
    state :: String,
    url :: String
  }
  deriving (Show, Eq)

generateURLs :: [Constituency]
-- generateURLs = concatMap (take 1 . generateConstituencies) generateStateDetails
generateURLs = concatMap generateConstituencies generateStateDetails
  where
    separator = "/"
    domain = "https://results.eci.gov.in"
    baseUrl = domain ++ separator ++ "PcResultGenJune2024"
    constituencyUrl = baseUrl ++ separator ++ "Constituencywise"

    createUrl :: String -> Int -> String
    createUrl stateCode constituencyNumber =
      constituencyUrl ++ stateCode ++ show constituencyNumber ++ ".htm"

    generateConstituencies :: StateDetail -> [Constituency]
    generateConstituencies (stateName, stateCode, numConstituencies) =
      [ Constituency
          { code = stateCode ++ show ctr,
            state = stateName,
            url = createUrl stateCode ctr
          }
        | ctr <- [1 .. numConstituencies]
      ]

processURLs :: [Constituency] -> FilePath -> FilePath -> IO ()
processURLs constituencies csvFilePath errorFilePath = do
  -- Delete the CSV and error files if they exist
  removeIfExists csvFilePath
  removeIfExists errorFilePath
  -- Open CSV file in append mode
  withFile csvFilePath AppendMode $ \csvHandle -> do
    -- Open error file in append mode
    withFile errorFilePath AppendMode $ \errorHandle -> do
      -- Process each URL one by one
      foldM_ (processEachURL csvHandle errorHandle) 1 (zip [1 ..] constituencies)
  where
    -- foldM_ (processEachURL csvHandle errorHandle) 1 (zip [1 ..] (take 3 constituencies))

    removeIfExists :: FilePath -> IO ()
    removeIfExists filePath = do
      fileExists <- doesFileExist filePath
      CM.when fileExists $ removeFile filePath

    processEachURL :: Handle -> Handle -> Int -> (Integer, Constituency) -> IO Int
    processEachURL csvHandle errorHandle counter pair = do
      let num = show $ fst pair
      let constituencyUrl = url $ snd pair
      let stateName = state $ snd pair
      putStrLn $ num ++ ". Processing " ++ constituencyUrl
      result <- try (fetchWebPage constituencyUrl) :: IO (Either FetchException String)
      case result of
        Left (FetchException code err) -> do
          hPutStrLn errorHandle $ formatCSVRow ["Missing", show code, constituencyUrl]
          return counter
        Right html -> do
          let rows = extractTable html
          let constituencyName = map toUpper (extractConstituencyName html)
          let massagedRows = massageRows stateName constituencyName counter rows
          persistResponse csvHandle massagedRows
          return $ counter + length massagedRows

    massageRows :: String -> String -> Int -> [[String]] -> [[String]]
    massageRows stateName constituencyName counter = zipWith addStateConstituencyNameAndCounter [counter ..]
      where
        addStateConstituencyNameAndCounter :: Int -> [String] -> [String]
        addStateConstituencyNameAndCounter cnt row = show cnt : stateName : constituencyName : row

    persistResponse :: Handle -> [[String]] -> IO ()
    persistResponse csvHandle = mapM_ (hPutStrLn csvHandle . formatCSVRow)

    fetchWebPage :: String -> IO String
    fetchWebPage url = do HC.fetchWebPage url

    extractTable :: String -> [[String]]
    extractTable html = fromMaybe [] (extractTableRows html)

    extractConstituencyName :: String -> String
    extractConstituencyName html = fromMaybe "" (constituencyNameFetcher html)

    appendStateName :: String -> [String] -> [String]
    appendStateName stateName lst = stateName : lst

    formatCSVRow :: [String] -> String
    formatCSVRow = intercalate ","
