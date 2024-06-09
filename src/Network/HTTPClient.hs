module Network.HTTPClient (fetchWebPage, FetchException(..)) where

import Control.Exception (Exception, SomeException, throwIO, toException)
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Network.HTTP.Simple

-- Define a custom exception type
data FetchException = FetchException Int String deriving (Show)

instance Exception FetchException

fetchWebPage :: String -> IO String
fetchWebPage url = do
  response <- httpLBS (parseRequest_ url)
  let statusCode = getResponseStatusCode response
  if statusCode /= 200
    then throwIO (FetchException statusCode ("Failed to fetch URL: " ++ url ++ " with status code: " ++ show statusCode))
    else do
      let responseBody = getResponseBody response
      let responseBodyStr = T.unpack $ TE.decodeUtf8 $ BL.toStrict responseBody
      return responseBodyStr