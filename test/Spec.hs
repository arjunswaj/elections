{-# LANGUAGE OverloadedStrings #-}

import CSV.CSVWriter (writeCSV)
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BL8
import Data.Csv (HasHeader (NoHeader), decode)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import qualified Data.Vector as V
import Elections (Constituency (..), generateURLs)
import Network.HTTPClient (fetchWebPage)
import Parser.HTMLParser (extractTableRows)
import System.Directory (doesFileExist, removeFile)
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "fetchWebPage" $ do
    it "fetches the webpage content" $ do
      content <- fetchWebPage "http://example.com"
      content `shouldContain` "<html>"

  describe "extractTableRows" $ do
    it "extracts rows from HTML table" $ do
      let filePath = "test.html"
      htmlContent <- BL.readFile filePath
      let htmlStr = T.unpack $ TE.decodeUtf8 $ BL.toStrict htmlContent
      extractTableRows htmlStr `shouldBe` Just expectedRows

  describe "writeCSV" $ do
    it "writes data to a CSV file" $ do
      let rows = [["http://example1.com", "Row1"], ["http://example2.com", "Row2"]]
      let filePath = "test_output.csv"
      writeCSV filePath rows
      fileExists <- doesFileExist filePath
      fileExists `shouldBe` True
      csvContent <- BL.readFile filePath
      let decoded = decode NoHeader csvContent :: Either String (V.Vector (V.Vector String))
      case decoded of
        Left err -> expectationFailure err
        Right v -> do
          V.length v `shouldBe` 2
          V.toList (v V.! 0) `shouldBe` ["http://example1.com", "Row1"]
          V.toList (v V.! 1) `shouldBe` ["http://example2.com", "Row2"]
      removeFile filePath

  describe "generateURLs" $ do
    it "generates the correct number of constituencies" $ do
      let actualConstituencies = generateURLs
      length actualConstituencies `shouldBe` 543


expectedRows = [["1", "AMAR SHARADRAO KALE", "Nationalist Congress Party – Sharadchandra Pawar", "530761", "2345", "533106", "48.68"], ["2", "RAMDAS CHANDRABHAN TADAS", "Bharatiya Janata Party", "449599", "1859", "451458", "41.23"]]
