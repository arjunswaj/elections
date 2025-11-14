{-# LANGUAGE ScopedTypeVariables #-}

module Network.HTTPClient (BrowserHandle, withBrowser, fetchWebPageWithBrowser, FetchException (..)) where

import Control.Exception (Exception, SomeException, bracket, catch, throwIO)
import Data.List (isPrefixOf)
import GHC.IO.Handle (BufferMode (..), hSetBuffering)
import System.IO (Handle, hFlush, hGetLine, hIsEOF, hPutStrLn)
import System.Process (ProcessHandle, StdStream (..), createProcess, proc, std_err, std_in, std_out, terminateProcess, waitForProcess)

-- Define a custom exception type
data FetchException = FetchException Int String deriving (Show)

instance Exception FetchException

-- Opaque handle to browser process
data BrowserHandle = BrowserHandle
  { browserStdin :: Handle,
    browserStdout :: Handle,
    browserProcess :: ProcessHandle
  }

-- Open browser session (resource acquisition)
openBrowser :: IO BrowserHandle
openBrowser = do
  (maybeStdin, maybeStdout, maybeStderr, ph) <-
    createProcess
      (proc "node" ["scraper-server.js"])
        { std_in = CreatePipe,
          std_out = CreatePipe,
          std_err = Inherit -- Show stderr for debugging
        }

  case (maybeStdin, maybeStdout) of
    (Just stdin, Just stdout) -> do
      hSetBuffering stdin LineBuffering
      hSetBuffering stdout LineBuffering
      return $ BrowserHandle stdin stdout ph
    _ -> throwIO $ FetchException 0 "Failed to create browser process pipes"

-- Close browser session (resource cleanup)
closeBrowser :: BrowserHandle -> IO ()
closeBrowser (BrowserHandle _ _ ph) = do
  terminateProcess ph
  _ <- waitForProcess ph
  return ()

-- Resource-safe browser session using bracket
withBrowser :: (BrowserHandle -> IO a) -> IO a
withBrowser = bracket openBrowser closeBrowser

-- Fetch a single page using an existing browser session
fetchWebPageWithBrowser :: BrowserHandle -> String -> [(String, String)] -> IO String
fetchWebPageWithBrowser (BrowserHandle stdin stdout _) url _headers = do
  -- Send URL to the scraper server
  hPutStrLn stdin url
  hFlush stdin

  -- Read response
  result <- readResponse stdout

  case result of
    Left err -> throwIO (FetchException 0 err)
    Right content -> return content
  where
    readResponse :: Handle -> IO (Either String String)
    readResponse h = do
      -- Read until we get the delimiter
      marker <- hGetLine h
      if marker == "===RESPONSE_START==="
        then readContent h []
        else return $ Left $ "Unexpected marker: " ++ marker

    readContent :: Handle -> [String] -> IO (Either String String)
    readContent h acc = do
      line <- hGetLine h
      if line == "===RESPONSE_END==="
        then return $ Right $ unlines (reverse acc)
        else
          if line == "===ERROR_START==="
            then readError h []
            else readContent h (line : acc)

    readError :: Handle -> [String] -> IO (Either String String)
    readError h acc = do
      line <- hGetLine h
      if line == "===ERROR_END==="
        then return $ Left $ unlines (reverse acc)
        else readError h (line : acc)
