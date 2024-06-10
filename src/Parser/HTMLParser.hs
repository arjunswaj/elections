module Parser.HTMLParser (extractTableRows, constituencyNameScraper) where

import Data.List (dropWhileEnd)
import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import Data.Text (pack, strip, unpack)
import Text.HTML.Scalpel

-- Define the type alias for readability
type Table = [[String]]

-- Selector for the table row
rowSelector :: Selector
rowSelector = TagString "table" @: [] // TagString "tbody" @: [] // TagString "tr" @: []

-- Selector for the table cell
cellSelector :: Selector
cellSelector = TagString "td" @: []

-- Function to extract all rows as lists of strings
extractTableRows :: String -> Maybe Table
extractTableRows html = scrapeStringLike html tableScraper

-- Define the scraper for the table
tableScraper :: Scraper String Table
tableScraper = chroots rowSelector rowScraper

-- Define the scraper for a single row
rowScraper :: Scraper String [String]
rowScraper = chroots cellSelector $ text anySelector

-- Define the selector
spanSelector :: Selector
spanSelector = TagString "div" @: [hasClass "page-title"] // TagString "h2" @: [] // TagString "span" @: []

-- Define the scraper
spanScraper :: Scraper String String
spanScraper = text spanSelector

-- Define the constituency name scraper
constituencyNameScraper :: String -> String
constituencyNameScraper htmlContent = extractConstituencyName $ Data.Maybe.fromMaybe "" (scrapeStringLike htmlContent spanScraper)

-- Function to extract the constituency name by removing the prefix
extractConstituencyName :: String -> String
extractConstituencyName input = case splitOn " - " input of
  (_ : name : _) -> unpack $ strip $ pack $ takeWhile (/= '(') name
  _ -> input
