module Demography.StateDetails (generateStateDetails, displayStateDetails, StateDetail) where

type StateDetail = (String, String, Int)

generateStateDetails :: [StateDetail]
generateStateDetails =
  [ -- States
    ("NEW DELHI", "U05", 70)
  ]

-- Example function to display state details
displayStateDetails :: StateDetail -> String
displayStateDetails (name, code, count) =
  "Name: " ++ name ++ ", Code: " ++ code ++ ", Number of Constituencies: " ++ show count
