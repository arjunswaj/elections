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
import Parser.HTMLParser (constituencyNameFetcher, extractTableRows)
import System.Directory (doesFileExist, removeFile)
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "fetchWebPage" $ do
    it "fetches the webpage content" $ do
      content <- fetchWebPage "http://example.com" []
      content `shouldContain` "<html>"

  describe "fetchElectionWebPage" $ do
    it "fetches the election webpage content" $ do
      let headers =
            [ (":authority", "results.eci.gov.in"),
              (":method", "GET"),
              (":path", "/AcResultGenOct2024/ConstituencywiseU0867.htm"),
              (":scheme", "https"),
              ("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"),
              ("accept-encoding", "gzip, deflate, br, zstd"),
              ("accept-language", "en-IN,en;q=0.9,hi-IN;q=0.8,hi;q=0.7,en-GB;q=0.6,en-US;q=0.5"),
              ("cache-control", "max-age=0"),
              ("cookie", "RT=\"z=1&dm=results.eci.gov.in&si=b16b28a4-e8cf-4f1e-ba3c-fd48c9cbcb95&ss=m2873m95&sl=e&tt=k3p&bcn=%2F%2F17de4c19.akstat.io%2F&ld=2kfyb&ul=2qql0\""),
              ("dnt", "1"),
              ("priority", "u=0, i"),
              ("referer", "https://results.eci.gov.in/AcResultGenOct2024/ConstituencywiseU0867.htm"),
              ("sec-ch-ua", "\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\""),
              ("sec-ch-ua-mobile", "?0"),
              ("sec-ch-ua-platform", "\"macOS\""),
              ("sec-fetch-dest", "document"),
              ("sec-fetch-mode", "navigate"),
              ("sec-fetch-site", "same-origin"),
              ("upgrade-insecure-requests", "1"),
              ("user-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36")
            ]
      content <- fetchWebPage "https://results.eci.gov.in/AcResultGenOct2024/ConstituencywiseU0867.htm" headers
      content `shouldContain` "html"

  describe "extractTableRows" $ do
    it "extracts rows from HTML table" $ do
      let filePath = "test.html"
      htmlContent <- BL.readFile filePath
      let htmlStr = T.unpack $ TE.decodeUtf8 $ BL.toStrict htmlContent
      extractTableRows htmlStr `shouldBe` Just expectedRows

  describe "Constituency Name Scraper" $ do
    it "extracts 'Davanagere' from the HTML" $ do
      let filePath = "heading.html"
      htmlContent <- BL.readFile filePath
      let htmlStr = T.unpack $ TE.decodeUtf8 $ BL.toStrict htmlContent
      constituencyNameFetcher htmlStr `shouldBe` Just "Davanagere"

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
      length actualConstituencies `shouldBe` 180

expectedRows = [["1", "AMAR SHARADRAO KALE", "Nationalist Congress Party – Sharadchandra Pawar", "530761", "2345", "533106", "48.68"], ["2", "RAMDAS CHANDRABHAN TADAS", "Bharatiya Janata Party", "449599", "1859", "451458", "41.23"]]
