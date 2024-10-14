module Demography.StateDetails (generateStateDetails, displayStateDetails, StateDetail) where

type StateDetail = (String, String, Int)

generateStateDetails :: [StateDetail]
generateStateDetails =
  [ -- States
    ("HARYANA", "S07", 90),
    ("JAMMU & KASHMIR", "U08", 90)
  ]

-- Example function to display state details
displayStateDetails :: StateDetail -> String
displayStateDetails (name, code, count) =
  "Name: " ++ name ++ ", Code: " ++ code ++ ", Number of Constituencies: " ++ show count
