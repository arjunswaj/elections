module Network.HTTPClient (fetchWebPage, FetchException(..)) where

import Network.HTTP.Types.Header (hUserAgent, hAccept, hAcceptLanguage, hCookie, hReferer, hCacheControl)
import Control.Exception (Exception, SomeException, throwIO, toException)
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Data.CaseInsensitive (mk)
import Network.HTTP.Simple
    ( parseRequest_,
      getResponseBody,
      getResponseStatusCode,
      httpLBS,
      setRequestHeader )

-- Define a custom exception type
data FetchException = FetchException Int String deriving (Show)

instance Exception FetchException

fetchWebPage :: String -> [(String, String)] -> IO String
fetchWebPage url headers = do
  -- Create a request with headers passed as an argument
  let request = foldr (\(name, value) req -> setRequestHeader (mk $ BS.pack name) [BS.pack value] req) (parseRequest_ url) headers
  response <- httpLBS request
  let statusCode = getResponseStatusCode response
  if statusCode /= 200
    then throwIO (FetchException statusCode ("Failed to fetch URL: " ++ url ++ " with status code: " ++ show statusCode))
    else do
      let responseBody = getResponseBody response
      let responseBodyStr = T.unpack $ TE.decodeUtf8 $ BL.toStrict responseBody
      return responseBodyStr
