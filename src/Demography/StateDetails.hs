module Demography.StateDetails (generateStateDetails, displayStateDetails, StateDetail) where

type StateDetail = (String, String, Int)

generateStateDetails :: [StateDetail]
generateStateDetails =
  [ -- States
    ("ASSAM", "S03", 126),
    ("KERALA", "S11", 140),
    ("TAMIL NADU", "S22", 234),
    ("WEST BENGAL", "S25", 294),
    -- Union Territories
    ("PUDUCHERRY", "U07", 30)

  ]

-- Example function to display state details
displayStateDetails :: StateDetail -> String
displayStateDetails (name, code, count) =
  "Name: " ++ name ++ ", Code: " ++ code ++ ", Number of Constituencies: " ++ show count
