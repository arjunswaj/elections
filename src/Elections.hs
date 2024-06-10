module Elections (processURLs, generateURLs, Constituency (..)) where

import CSV.CSVWriter (writeCSV)
import Control.Exception (SomeException, try)
import qualified Control.Monad as CM
import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import Demography.StateDetails
  ( StateDetail,
    generateStateDetails,
  )
import Network.HTTPClient (FetchException (..), fetchWebPage)
import Parser.HTMLParser (extractTableRows)
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
generateURLs = concatMap (take 1 . generateConstituencies) generateStateDetails
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
      mapM_ (processURL csvHandle errorHandle) (zip [1 ..] (take 3 constituencies))
  where
    removeIfExists :: FilePath -> IO ()
    removeIfExists filePath = do
      fileExists <- doesFileExist filePath
      CM.when fileExists $ removeFile filePath

    processURL :: Handle -> Handle -> (Integer, Constituency) -> IO ()
    processURL csvHandle errorHandle pair = do
      let num = show $ fst pair
      let constituencyUrl = url $ snd pair
      let stateName = state $ snd pair
      putStrLn $ num ++ ". Processing " ++ constituencyUrl
      result <- try (fetchAndParse constituencyUrl) :: IO (Either FetchException [[String]])
      case result of
        Left (FetchException code err) -> hPutStrLn errorHandle $ formatCSVRow ["Missing", show code, constituencyUrl]
        Right [] -> hPutStrLn errorHandle $ formatCSVRow ["No rows present", "0", constituencyUrl]
        Right (x : xs) -> mapM_ ((hPutStrLn csvHandle . formatCSVRow) . appendStateName stateName) (x : xs)

    fetchAndParse :: String -> IO [[String]]
    fetchAndParse url = do
      html <- fetchWebPage url
      let rows = fromMaybe [] (extractTableRows html)
      return rows

    appendStateName :: String -> [String] -> [String]
    appendStateName stateName lst = stateName : lst

    formatCSVRow :: [String] -> String
    formatCSVRow = intercalate ","
