module Network.HTTPClient (fetchWebPage) where

import Network.HTTP.Simple

fetchWebPage :: String -> IO String
fetchWebPage url = do
  response <- httpLBS (parseRequest_ url)
  return $ show (getResponseBody response)
