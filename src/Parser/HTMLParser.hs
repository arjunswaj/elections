module Parser.HTMLParser (extractTableRows) where

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
