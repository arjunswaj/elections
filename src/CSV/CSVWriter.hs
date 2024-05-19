module CSV.CSVWriter (writeCSV) where

import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

writeCSV :: FilePath -> [[String]] -> IO ()
writeCSV filePath rows = BL.writeFile filePath $ encodeByName header (map toNamedRecord rows)
  where
    header = V.fromList [B.pack "URL", B.pack "Data"]
    toNamedRecord :: [String] -> NamedRecord
    toNamedRecord (url : dataStr) = namedRecord [B.pack "URL" .= B.pack url, B.pack "Data" .= B.pack (unwords dataStr)]
    toNamedRecord _ = error "Invalid row format"
