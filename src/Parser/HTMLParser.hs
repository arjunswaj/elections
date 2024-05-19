module Parser.HTMLParser (extractTableRows) where

import Text.HTML.TagSoup

extractTableRows :: String -> [[String]]
extractTableRows html =
  let tags = parseTags html
      rows = sections (~== "<tr>") tags
   in map (map fromTagText . filter isTagText . parseTags . innerText) rows