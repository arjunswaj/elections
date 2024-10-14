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
    url :: String,
    headers :: [(String, String)]
  }
  deriving (Show, Eq)

generateURLs :: [Constituency]
-- generateURLs = concatMap (take 1 . generateConstituencies) generateStateDetails
generateURLs = concatMap generateConstituencies generateStateDetails
  where
    separator = "/"
    domain = "https://results.eci.gov.in"
    baseUrl = separator ++ "PcResultGenJune2024"
    constituencyUrl = baseUrl ++ separator ++ "Constituencywise"

    createUrl :: String -> Int -> String
    createUrl stateCode constituencyNumber =
      constituencyUrl ++ stateCode ++ show constituencyNumber ++ ".htm"

    generateHeaders :: String -> Int -> [(String, String)]
    generateHeaders stateCode ctr =
      [ (":authority", "results.eci.gov.in"),
        (":method", "GET"),
        (":path", createUrl stateCode ctr),
        (":scheme", "https"),
        ("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"),
        ("accept-encoding", "gzip, deflate, br, zstd"),
        ("accept-language", "en-IN,en;q=0.9,hi-IN;q=0.8,hi;q=0.7,en-GB;q=0.6,en-US;q=0.5"),
        ("cache-control", "max-age=0"),
        ("cookie", "RT=\"z=1&dm=results.eci.gov.in&si=b16b28a4-e8cf-4f1e-ba3c-fd48c9cbcb95&ss=m2873m95&sl=e&tt=k3p&bcn=%2F%2F17de4c19.akstat.io%2F&ld=2kfyb&ul=2qql0\""),
        ("dnt", "1"),
        ("priority", "u=0, i"),
        ("referer", domain),
        ("sec-ch-ua", "\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\""),
        ("sec-ch-ua-mobile", "?0"),
        ("sec-ch-ua-platform", "\"macOS\""),
        ("sec-fetch-dest", "document"),
        ("sec-fetch-mode", "navigate"),
        ("sec-fetch-site", "same-origin"),
        ("upgrade-insecure-requests", "1"),
        ("user-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36")
      ]

    generateConstituencies :: StateDetail -> [Constituency]
    generateConstituencies (stateName, stateCode, numConstituencies) =
      [ Constituency
          { code = stateCode ++ show ctr,
            state = stateName,
            url = domain ++ createUrl stateCode ctr,
            headers = generateHeaders stateCode ctr
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
      let urlCode = code $ snd pair
      let requestHeaders = headers $ snd pair
      putStrLn $ num ++ ". Processing " ++ constituencyUrl
      result <- try (fetchWebPage constituencyUrl requestHeaders) :: IO (Either FetchException String)
      case result of
        Left (FetchException code err) -> do
          hPutStrLn errorHandle $ formatCSVRow ["Missing", show code, constituencyUrl]
          return counter
        Right html -> do
          let rows = extractTable html
          let constituencyName = map toUpper (extractConstituencyName html)
          let massagedRows = removeSpecialCharacters $ massageRows urlCode stateName constituencyName counter rows
          persistResponse csvHandle massagedRows
          return $ counter + length massagedRows

    -- Function to remove special characters from a single string
    removeSpecialCharsFromString :: String -> String
    removeSpecialCharsFromString = filter (`notElem` ",'\"")

    -- Function to remove special characters from a list of lists of strings
    removeSpecialCharacters :: [[String]] -> [[String]]
    removeSpecialCharacters = map (map removeSpecialCharsFromString)

    massageRows :: String -> String -> String -> Int -> [[String]] -> [[String]]
    massageRows urlCode stateName constituencyName counter = zipWith addStateConstituencyNameAndCounter [counter ..]
      where
        addStateConstituencyNameAndCounter :: Int -> [String] -> [String]
        addStateConstituencyNameAndCounter cnt row = show cnt : urlCode : stateName : constituencyName : row

    persistResponse :: Handle -> [[String]] -> IO ()
    persistResponse csvHandle = mapM_ (hPutStrLn csvHandle . formatCSVRow)

    fetchWebPage :: String -> [(String, String)] -> IO String
    fetchWebPage url headers = do HC.fetchWebPage url headers

    extractTable :: String -> [[String]]
    extractTable html = fromMaybe [] (extractTableRows html)

    extractConstituencyName :: String -> String
    extractConstituencyName html = fromMaybe "" (constituencyNameFetcher html)

    appendStateName :: String -> [String] -> [String]
    appendStateName stateName lst = stateName : lst

    formatCSVRow :: [String] -> String
    formatCSVRow = intercalate ","
