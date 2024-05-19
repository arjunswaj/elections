{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import Network.HTTPClient (fetchWebPage)
import Parser.HTMLParser (extractTableRows)
import CSV.CSVWriter (writeCSV)
import System.Directory (removeFile, doesFileExist)
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BL8

main :: IO ()
main = hspec $ do
  describe "fetchWebPage" $ do
    it "fetches the webpage content" $ do
      content <- fetchWebPage "http://example.com"
      content `shouldContain` "<html>"

  describe "extractTableRows" $ do
    it "extracts rows from HTML table" $ do
      let html = "<table><tr><td>Row1</td></tr><tr><td>Row2</td></tr></table>"
      extractTableRows html `shouldBe` [["Row1"], ["Row2"]]

  describe "writeCSV" $ do
    it "writes data to a CSV file" $ do
      let rows = [["http://example.com", "Row1"], ["http://example.com", "Row2"]]
      let filePath = "test_output.csv"
      writeCSV filePath rows
      fileExists <- doesFileExist filePath
      fileExists `shouldBe` True
      csvContent <- BL.readFile filePath
      BL8.unpack csvContent `shouldContain` "URL,Data"
      removeFile filePath
