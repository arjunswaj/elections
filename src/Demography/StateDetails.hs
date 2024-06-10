module Demography.StateDetails (generateStateDetails, displayStateDetails, StateDetail) where

type StateDetail = (String, String, Int)

generateStateDetails :: [StateDetail]
generateStateDetails =
  [ -- States
    ("ANDHRA PRADESH", "S01", 25),
    ("ARUNACHAL PRADESH", "S02", 2),
    ("ASSAM", "S03", 14),
    ("BIHAR", "S04", 40),
    ("GOA", "S05", 2),
    ("GUJARAT", "S06", 26),
    ("HARYANA", "S07", 10),
    ("HIMACHAL PRADESH", "S08", 4),
    -- Missing Sequence S09
    ("KARNATAKA", "S10", 28),
    ("KERALA", "S11", 20),
    ("MADHYA PRADESH", "S12", 29),
    ("MAHARASHTRA", "S13", 48),
    ("MANIPUR", "S14", 2),
    ("MEGHALAYA", "S15", 2),
    ("MIZORAM", "S16", 1),
    ("NAGALAND", "S17", 1),
    ("ODISHA", "S18", 21),
    ("PUNJAB", "S19", 13),
    ("RAJASTHAN", "S20", 25),
    ("SIKKIM", "S21", 1),
    ("TAMIL NADU", "S22", 39),
    ("TRIPURA", "S23", 2),
    ("UTTAR PRADESH", "S24", 80),
    ("WEST BENGAL", "S25", 42),
    -- Out of alphabetic order
    ("CHHATTISGARH", "S26", 11),
    ("JHARKHAND", "S27", 14),
    ("UTTARAKHAND", "S28", 5),
    ("TELANGANA", "S29", 17),
    -- Union Territories
    ("ANDAMAN & NICOBAR ISLANDS", "U01", 1),
    ("CHANDIGARH", "U02", 1),
    ("DADRA & NAGAR HAVELI AND DAMAN & DIU", "U03", 2),
    -- Missing sequence U04
    ("DELHI", "U05", 7),
    ("LAKSHADWEEP", "U06", 1),
    ("PUDUCHERRY", "U07", 1),
    -- Out of alphabetic order
    ("JAMMU & KASHMIR", "U08", 5),
    ("LADAKH", "U09", 1)
  ]

-- Example function to display state details
displayStateDetails :: StateDetail -> String
displayStateDetails (name, code, count) =
  "Name: " ++ name ++ ", Code: " ++ code ++ ", Number of Constituencies: " ++ show count
