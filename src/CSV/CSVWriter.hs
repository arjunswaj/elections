module CSV.CSVWriter (writeCSV) where

import qualified Data.ByteString.Lazy as BL
import Data.Csv ( defaultEncodeOptions, encodeWith, Field )
import System.IO (FilePath)
import qualified Data.Text.Encoding as TE
import Data.Text (pack)

writeCSV :: FilePath -> [[String]] -> IO ()
writeCSV path rows = BL.writeFile path (encode rows)
  where
    encode :: [[String]] -> BL.ByteString
    encode = encodeWith defaultEncodeOptions . map (map toField)

    toField :: String -> Field
    toField = TE.encodeUtf8 . pack
