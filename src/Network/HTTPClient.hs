{-# LANGUAGE ScopedTypeVariables #-}

module Network.HTTPClient (fetchWebPage, FetchException(..)) where

import Control.Exception (Exception, throwIO, catch, SomeException)
import System.Process (readProcess)
import System.Exit (ExitCode(..))
import qualified Data.Text as T
import Data.List (intercalate)

-- Define a custom exception type
data FetchException = FetchException Int String deriving (Show)

instance Exception FetchException

fetchWebPage :: String -> [(String, String)] -> IO String
fetchWebPage url _headers = do
  -- Use Node.js/Playwright scraper to bypass bot detection
  -- The scraper.js script must be in the current directory
  result <- (do
    output <- readProcess "node" ["scraper.js", url] ""
    return $ Right output
    ) `catch` (\(e :: SomeException) -> return $ Left $ show e)
  
  case result of
    Left err -> throwIO (FetchException 0 ("Failed to fetch URL with Node scraper: " ++ err))
    Right output -> 
      if null output
        then throwIO (FetchException 0 ("Empty response from " ++ url))
        else return output
