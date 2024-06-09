module Network.HTTPClient (fetchWebPage) where

import Network.HTTP.Simple
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE

fetchWebPage :: String -> IO String
fetchWebPage url = do
  response <- httpLBS (parseRequest_ url)
  let responseBody = getResponseBody response
  let responseBodyStr = T.unpack $ TE.decodeUtf8 $ BL.toStrict responseBody
  return responseBodyStr
