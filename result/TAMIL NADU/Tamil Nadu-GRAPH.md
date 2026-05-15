# Table of contents

- [Analysis of Tamil Nadu Assembly Elections May 2026](#analysis-of-tamil-nadu-assembly-elections-may-2026)
* [Analysis](#analysis)
+ [Seats contested by Parties](#seats-contested-by-parties)
+ [Max and Mins](#max-and-mins)
- [Maximum votes for a candidate](#maximum-votes-for-a-candidate)
- [Least votes for a winning candidate](#least-votes-for-a-winning-candidate)
- [Max votes for a losing candidate](#max-votes-for-a-losing-candidate)
- [Candidates winning by Max margin (Unilateral winner)](#candidates-winning-by-max-margin-unilateral-winner)
- [Candidates winning by Least margin (Fierce battle)](#candidates-winning-by-least-margin-fierce-battle)
+ [Max and Mins - Constituencies](#max-and-mins---constituencies)
- [Max Total Votes in a Constituency](#max-total-votes-in-a-constituency)
- [Min Total Votes Constituency](#min-total-votes-constituency)
- [Max candidates in a Constituency](#max-candidates-in-a-constituency)
- [Least candidates in a Constituency](#least-candidates-in-a-constituency)
+ [Vote Shares](#vote-shares)
- [Total Vote Share of Parties](#total-vote-share-of-parties)
- [Maximum Vote share of Winning Candidate](#maximum-vote-share-of-winning-candidate)
- [Least Vote share for a winning candidate](#least-vote-share-for-a-winning-candidate)
- [Max Vote share of a losing candidate](#max-vote-share-of-a-losing-candidate)
- [Seats in which Parties lost deposits (less than 1/6 vote share)](#seats-in-which-parties-lost-deposits-less-than-16-vote-share)
+ [Medals](#medals)
- [Gold (Seats that Parties won)](#gold-seats-that-parties-won)
- [Silver (Seats that Parties came in second)](#silver-seats-that-parties-came-in-second)
+ [Strike Rates](#strike-rates)
- [Cost per vote - Best Value per vote](#cost-per-vote---best-value-per-vote)
- [Cost per vote - Worst Value per vote](#cost-per-vote---worst-value-per-vote)
- [Success Ratio - Best](#success-ratio---best)
- [Success Ratio - Worst](#success-ratio---worst)
+ [Multiple Seat Participation](#multiple-seat-participation)
- [Candidates participating in multiple seats (matches names)](#candidates-participating-in-multiple-seats-matches-names)
+ [Close Contest Matrix](#close-contest-matrix)
- [Party Specific Close Contest Matrix](#party-specific-close-contest-matrix)
     * [All India Anna Dravida Munnetra Kazhagam](#all-india-anna-dravida-munnetra-kazhagam)
     * [Dravida Munnetra Kazhagam](#dravida-munnetra-kazhagam)
     * [Indian National Congress](#indian-national-congress)
     * [Tamilaga Vettri Kazhagam](#tamilaga-vettri-kazhagam)
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of Tamil Nadu Assembly Elections May 2026

The 2026 Tamil Nadu Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting overseen by the Election Commission of India soon after polling.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/TAMIL NADU).

## Analysis
A total of 4023 candidates contested in the Tamil Nadu assembly elections and about 4.93 Crore (`49324121`) votes were cast during this period.

### Seats contested by Parties

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Seats Contested by Parties"
x-axis ["Independent", "NTK", "TVK", "DMK", "AIADMK", "Tamizhaga Vaazhvurimai Katchi", "BSP", "All India Puratchi Thalaivar Makkal Munnettra Kazhagam", "Puthiya Tamilagam", "BJP"]
y-axis "Number of Seats" 0 --> 2650
bar [2209, 234, 233, 176, 172, 164, 119, 78, 60, 33]
```

### Max and Mins

#### Maximum votes for a candidate

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Maximum Votes for a Candidate"
x-axis ["ECR P SARAVANAN (TVK, SHOZHINGANALLUR)", "M.L.VIJAYPRABHU (TVK, MADAVARAM)", "R.RAMESH KUMAR (TVK, AVADI)", "PRAKASAM.R (TVK, POONAMALLEE)", "EDAPPADI PALANISWAMI. K (AIADMK, EDAPPADI)"]
y-axis "Number of Votes" 134039 --> 242420
bar [220382, 190462, 180384, 161309, 148933]
```

#### Least votes for a winning candidate

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Least Votes for a Winning Candidate"
x-axis ["P K SEKARBABU (DMK, HARBOUR)", "BHOJARAJAN.M (BJP, UDHAGAMANDALAM)", "M. RAJU (DMK, COONOOR)", "ANAND N (TVK, THIYAGARAYANAGAR)", "RAJMOHAN (TVK, EGMORE)"]
y-axis "Number of Votes" 40728 --> 59291
bar [45254, 48488, 50470, 51632, 53901]
```

#### Max votes for a losing candidate

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Max Votes for a Losing Candidate"
x-axis ["S. ARAVIND RAMESH (DMK, SHOZHINGANALLUR)", "ARUNKUMAR PRG (AIADMK, KAVUNDAMPALAYAM)", "S.M.NASAR (DMK, AVADI)", "MOORTHY P (DMK, MADURAI EAST)", "KARTHIKDHANDAPANI (DMK, CHENGALPATTU)"]
y-axis "Number of Votes" 91345 --> 135962
bar [123602, 104326, 104073, 102230, 101495]
```

#### Candidates winning by Max margin (Unilateral winner)

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Candidates Winning by Max Margin"
x-axis ["TIRUPPATTUR (SEENIVASA SETHUPATHY. R, TAMIL NADU)", "VEPPANAHALLI (SRINIVASAN.P.S, TAMIL NADU)", "KANNIYAKUMARI (THALAVAI SUNDARAM. N, TAMIL NADU)", "POLUR (ABISHEK. R, TAMIL NADU)", "TIRUKKOYILUR (PALANISAMY S, TAMIL NADU)"]
y-axis "Vote Difference" 65473 --> 91711
bar [83374, 74553, 74831, 67734, 72748]
```

#### Candidates winning by Least margin (Fierce battle)

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Candidates Winning by Least Margin"
x-axis ["SALEM (LAKSHMANAN.S, TAMIL NADU)", "AVADI (R.RAMESH KUMAR, TAMIL NADU)", "MADAVARAM (M.L.VIJAYPRABHU, TAMIL NADU)", "SHOZHINGANALLUR (ECR P SARAVANAN, TAMIL NADU)", "EDAPPADI (EDAPPADI PALANISWAMI. K, TAMIL NADU)"]
y-axis "Vote Difference" 0 --> 60987
bar [45540, 104073, 95477, 123602, 50823]
```

#### Max Total Votes in a Constituency

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Max Total Votes in a Constituency"
x-axis ["SHOZHINGANALLUR (TAMIL NADU)", "KAVUNDAMPALAYAM (TAMIL NADU)", "MADAVARAM (TAMIL NADU)", "AVADI (TAMIL NADU)", "SRIPERUMBUDUR (TAMIL NADU)"]
y-axis "Total Votes" 297979 --> 492024
bar [447295, 363991, 361998, 346005, 331088]
```

#### Min Total Votes Constituency

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Min Total Votes in a Constituency"
x-axis ["THIYAGARAYANAGAR (TAMIL NADU)", "THOUSAND LIGHTS (TAMIL NADU)", "ROYAPURAM (TAMIL NADU)", "EGMORE (TAMIL NADU)", "HARBOUR (TAMIL NADU)"]
y-axis "Total Votes" 120535 --> 109584
bar [133928, 131824, 127356, 119738, 99622]
```

#### Max Candidates in a Constituency

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Max Candidates in a Constituency"
x-axis ["KARUR (TAMIL NADU)", "PERAMBUR (TAMIL NADU)", "DR.RADHAKRISHNAN NAGAR (TAMIL NADU)", "KOLATHUR (TAMIL NADU)", "COIMBATORE (TAMIL NADU)"]
y-axis "Number of Candidates" 0 --> 96
bar [80, 48, 39, 36, 32]
```

#### Least Candidates in a Constituency

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Least Candidates in a Constituency"
x-axis ["UDHAGAMANDALAM (TAMIL NADU)", "GUDALUR (TAMIL NADU)", "MADURAI SOUTH (TAMIL NADU)", "AMBASAMUDRAM (TAMIL NADU)", "KINATHUKADAVU (TAMIL NADU)"]
y-axis "Number of Candidates" 0 --> 12
bar [7, 7, 7, 6, 6]
```

#### Total Vote Share of Parties

```mermaid
pie title Total Vote Share of Parties
  "TVK" : 34.92
  "DMK" : 24.19
  "AIADMK" : 21.21
  "NTK" : 4.00
  "INC" : 3.37
```

#### Maximum Vote Share of Winning Candidate

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Maximum Vote Share of Winning Candidate"
x-axis ["C. JOSEPH VIJAY (TVK, PERAMBUR)", "EDAPPADI PALANISWAMI. K (AIADMK, EDAPPADI)", "N. MARIE WILSON (TVK, DR.RADHAKRISHNAN NAGAR)", "SENTHIL KUMAR. N (TVK, THIRUVOTTIYUR)", "M.L.VIJAYPRABHU (TVK, MADAVARAM)"]
y-axis "Vote Share" 47.61 --> 63.89
bar [58.89, 57.67, 53.97, 53.15, 52.61]
```

#### Least Vote Share for a Winning Candidate

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Least Vote Share for a Winning Candidate"
x-axis ["VIJAY. M (TVK, USILAMPATTI)", "R.S.RAJAKANNAPPAN (DMK, MUDHUKULATHUR)", "SUNILANAND (TVK, METTUPPALAYAM)", "ADVOCATE. KATHIRAVAN. K.K (DMK, PARAMAKUDI)", "KADARKARAIRAJ. A (DMK, SATTUR)"]
y-axis "Vote Share" 24.34 --> 36.23
bar [29.34, 29.39, 30.97, 31.18, 31.23]
```

#### Max Vote Share of a Losing Candidate

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Max Vote Share of a Losing Candidate"
x-axis ["G.RAMAMOORTHI (TVK, TIRUCHIRAPPALLI)", "M. K. STALIN (DMK, KOLATHUR)", "ERAMAKRISHNAN N (DMK, CUMBUM)", "SELVAM. D (TVK, CHEPAUK-THIRUVALLIKENI)", "ARUL ARUMUGAM (TVK, TIRUVANNAMALAI)"]
y-axis "Vote Share" 34.00 --> 47.50
bar [42.50, 40.32, 40.20, 39.68, 39.00]
```

#### Seats in which Parties Lost Deposits (less than 1/6 vote share)

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Seats in which Parties Lost Deposits"
x-axis ["Independent", "NTK", "NOTA", "Tamizhaga Vaazhvurimai Katchi", "BSP"]
y-axis "Number of Seats" 0 --> 2649
bar [2208, 234, 234, 164, 119]
```

#### Gold (Seats that Parties Won)

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Gold (Seats that Parties Won)"
x-axis ["TVK", "DMK", "AIADMK", "INC", "PMK"]
y-axis "Number of Seats" 0 --> 123
bar [103, 57, 47, 5, 4]
```

#### Silver (Seats that Parties Came in Second)

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Silver (Seats that Parties Came in Second)"
x-axis ["DMK", "TVK", "AIADMK", "INC", "BJP"]
y-axis "Number of Seats" 0 --> 90
bar [75, 75, 43, 10, 8]
```

#### Cost per Vote - Best Value

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Cost per Vote - Best Value"
x-axis ["TVK", "IUML", "DMK", "VCK", "CPI"]
y-axis "Cost per Vote" 0 --> 73
bar [54.10, 56.15, 59.02, 59.25, 61.26]
```

#### Cost per Vote - Worst Value

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Cost per Vote - Worst Value"
x-axis ["Indian Christian Front", "Indhia Kudiarasu Katchi", "Tamilnadu Mahatma Gandhi Makkal Katchi", "ALL PENSIONERS PARTY", "Makkalatchi Katchi"]
y-axis "Cost per Vote" 0 --> 104347
bar [47058.82, 48780.49, 56338.03, 72727.27, 86956.52]
```

#### Success Ratio - Best


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Pattali Makkal Katchi | 17 | 4 | 23.52941176470588235300 |
| Indian National Congress | 28 | 5 | 17.85714285714285714300 |
| Desiya Murpokku Dravida Kazhagam | 10 | 1 | 10.00000000000000000000 |
| Amma Makkal Munnettra Kazagam | 11 | 1 | 9.09090909090909090900 |
| Bharatiya Janata Party | 33 | 1 | 3.03030303030303030300 |

#### Success Ratio - Worst


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Bharatiya Janata Party | 33 | 1 | 3.03030303030303030300 |
| Amma Makkal Munnettra Kazagam | 11 | 1 | 9.09090909090909090900 |
| Desiya Murpokku Dravida Kazhagam | 10 | 1 | 10.00000000000000000000 |
| Indian National Congress | 28 | 5 | 17.85714285714285714300 |
| Pattali Makkal Katchi | 17 | 4 | 23.52941176470588235300 |

### Multiple Seat Participation

#### Results of Candidates participating in multiple seats

| Candidate | Constituency | Code | Party | Result |
| --- | --- | --- | --- | --- |
| C. JOSEPH VIJAY | TIRUCHIRAPPALLI | S22141 | Tamilaga Vettri Kazhagam | WON |
| C. JOSEPH VIJAY | PERAMBUR | S2212 | Tamilaga Vettri Kazhagam | WON |
| SIVAKUMAR. K | PERAMBALUR | S22147 | Tamilaga Vettri Kazhagam | WON |
| SIVAKUMAR. K | SALEM | S2289 | Tamilaga Vettri Kazhagam | WON |
| R.MANOHARAN | SRIRANGAM | S22139 | All India Anna Dravida Munnetra Kazhagam | LOST |
| R.MANOHARAN | ERODE | S2298 | All India Anna Dravida Munnetra Kazhagam | LOST |
| AGNI AALVAR | CHEPAUK-THIRUVALLIKENI | S2219 | Independent | LOST |
| AGNI AALVAR | PERAMBUR | S2212 | Independent | LOST |
| A. RAMESH | PALLADAM | S22115 | Independent | LOST |
| A. RAMESH | COIMBATORE | S22118 | Independent | LOST |

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

| Losing Party | < 500 | < 2500 | < 5000 | < 10000 | < 15000 | < 25000 | < 50000 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| All India Anna Dravida Munnetra Kazhagam | 1 | 7 | 16 | 26 | 31 | 38 | 43 |
| Amma Makkal Munnettra Kazagam | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
| Bharatiya Janata Party | 0 | 1 | 1 | 4 | 6 | 7 | 8 |
| Communist Party of India | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
| Desiya Murpokku Dravida Kazhagam | 1 | 1 | 1 | 2 | 3 | 3 | 3 |
| Dravida Munnetra Kazhagam | 3 | 9 | 13 | 22 | 37 | 55 | 73 |
| Indian National Congress | 0 | 0 | 1 | 1 | 4 | 8 | 9 |
| Pattali Makkal Katchi | 0 | 0 | 1 | 2 | 3 | 3 | 4 |
| Tamilaga Vettri Kazhagam | 1 | 17 | 28 | 46 | 58 | 68 | 73 |
| Viduthalai Chiruthaigal Katchi | 0 | 0 | 0 | 0 | 1 | 3 | 4 |

#### Party Specific Close Contest Matrix


##### All India Anna Dravida Munnetra Kazhagam

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| VEPPANAHALLI | S2254 | 74553 | Dravida Munnetra Kazhagam | 74691 | 138 |
| TINDIVANAM | S2272 | 63099 | Viduthalai Chiruthaigal Katchi | 63833 | 734 |
| KALLAKURICHI | S2280 | 80334 | Tamilaga Vettri Kazhagam | 81132 | 798 |
| SRIVAIKUNTAM | S22216 | 57628 | Tamilaga Vettri Kazhagam | 58814 | 1186 |
| MANAPPARAI | S22138 | 81615 | Tamilaga Vettri Kazhagam | 83041 | 1426 |


##### Dravida Munnetra Kazhagam

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| TIRUPPATTUR | S22185 | 83374 | Tamilaga Vettri Kazhagam | 83375 | 1 |
| KANNIYAKUMARI | S22229 | 74831 | All India Anna Dravida Munnetra Kazhagam | 75045 | 214 |
| PARAMATHI-VELUR | S2295 | 61041 | All India Anna Dravida Munnetra Kazhagam | 61349 | 308 |
| KUMBAKONAM | S22171 | 77971 | Tamilaga Vettri Kazhagam | 78650 | 679 |
| CUMBUM | S22201 | 84643 | Tamilaga Vettri Kazhagam | 85394 | 751 |


##### Indian National Congress

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| TIRUVADANAI | S22210 | 67038 | Tamilaga Vettri Kazhagam | 69551 | 2513 |
| ARANTHANGI | S22183 | 63182 | Tamilaga Vettri Kazhagam | 73244 | 10062 |
| AMBASAMUDRAM | S22225 | 55344 | All India Anna Dravida Munnetra Kazhagam | 65589 | 10245 |
| SIVAKASI | S22205 | 57039 | Tamilaga Vettri Kazhagam | 68709 | 11670 |
| CUDDALORE | S22155 | 55337 | Tamilaga Vettri Kazhagam | 70856 | 15519 |


##### Tamilaga Vettri Kazhagam

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| TIRUKKOYILUR | S2276 | 72748 | All India Anna Dravida Munnetra Kazhagam | 73033 | 285 |
| KULITHALAI | S22137 | 67559 | Dravida Munnetra Kazhagam | 68138 | 579 |
| PALANI | S22127 | 66293 | All India Anna Dravida Munnetra Kazhagam | 66986 | 693 |
| KOVILPATTI | S22218 | 60800 | Dravida Munnetra Kazhagam | 61643 | 843 |
| VIKRAVANDI | S2275 | 68817 | Pattali Makkal Katchi | 69727 | 910 |


### Advanced Join Insights

#### Crowding pressure seats

Crowded ballots with thin margins are visualized below using "others" vote share as a proxy for fragmentation.

| Code | Constituency | Winning Party | Runner Up Party | Candidate Count | Others Vote % | Margin Votes | Margin % | Postal Gap | Crowding Band |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S22197 | USILAMPATTI | Tamilaga Vettri Kazhagam | All India Anna Dravida Munnetra Kazhagam | 13 | 42.12 | 1805 | 0.80 | 318 | Crowded |
| S22111 | METTUPPALAYAM | Tamilaga Vettri Kazhagam | Dravida Munnetra Kazhagam | 23 | 41.25 | 7768 | 3.18 | -409 | Ultra-crowded |
| S22223 | ALANGULAM | Dravida Munnetra Kazhagam | All India Anna Dravida Munnetra Kazhagam | 14 | 40.90 | 7798 | 3.53 | 408 | Crowded |
| S22204 | SATTUR | Dravida Munnetra Kazhagam | Bharatiya Janata Party | 23 | 40.56 | 5989 | 3.02 | 112 | Ultra-crowded |
| S22209 | PARAMAKUDI | Dravida Munnetra Kazhagam | Tamilaga Vettri Kazhagam | 13 | 39.51 | 3548 | 1.87 | 187 | Crowded |

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Crowding Pressure - Others Vote Share"
x-axis ["USILAMPATTI", "METTUPPALAYAM", "ALANGULAM", "SATTUR", "PARAMAKUDI"]
y-axis "Others Vote %" 0 --> 50
bar [42.12, 41.25, 40.90, 40.56, 39.51]
```

#### Runner-up overperformance vs party baseline

These runner-up candidates beat their party-wide average vote share even in defeat.

| Constituency | Candidate | Party | Runner Up % | Party Avg % | Overperformance % | Constituencies |
| --- | --- | --- | --- | --- | --- | --- |
| EDAPPADI | PREMKUMAR. K | Independent | 19.68 | 0.11 | 19.57 | 2209 |
| THALLI | DR.NAGESH KUMAR. C | Bharatiya Janata Party | 35.48 | 22.59 | 12.89 | 33 |
| MADATHUKULAM | C SHANMUGAVELU | Amma Makkal Munnettra Kazagam | 28.95 | 18.48 | 10.47 | 11 |
| MODAKKURICHI | S.KIRTHIKA | Bharatiya Janata Party | 30.55 | 22.59 | 7.96 | 33 |
| KOLATHUR | M. K. STALIN | Dravida Munnetra Kazhagam | 40.32 | 32.49 | 7.83 | 176 |

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Runner-up Overperformance"
x-axis ["EDAPPADI", "THALLI", "MADATHUKULAM", "MODAKKURICHI", "KOLATHUR"]
y-axis "Overperformance %" 0 --> 35
bar [19.57, 12.89, 10.47, 7.96, 7.83]
```

#### HHI win mix by party

Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types.

| Party | HHI Band | Seats Won |
| --- | --- | --- |
| All India Anna Dravida Munnetra Kazhagam | Competitive | 2 |
| All India Anna Dravida Munnetra Kazhagam | Fragmented | 45 |
| Amma Makkal Munnettra Kazagam | Fragmented | 1 |
| Bharatiya Janata Party | Fragmented | 1 |
| Communist Party of India | Fragmented | 2 |
| Communist Party of India (Marxist) | Fragmented | 2 |
| Desiya Murpokku Dravida Kazhagam | Fragmented | 1 |
| Dravida Munnetra Kazhagam | Competitive | 2 |
| Dravida Munnetra Kazhagam | Fragmented | 57 |
| Indian National Congress | Fragmented | 5 |

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "HHI Win Mix by Party"
x-axis ["Competitive", "Dominant", "Fragmented"]
y-axis "Seats Won" 0 --> 100
bar "Viduthalai" [0, 0, 0]
bar "Tamilaga" [0, 0, 0]
bar "Pattali" [0, 0, 0]
bar "Indian" [0, 0, 0]
bar "Indian" [0, 0, 0]
```

#### Third-place spoilers in tight races

Third-place candidacies that materially exceeded their party's norm highlight potential spoiler roles.

```mermaid
---
config:
  xyChart:
    width: 1200
    height: 600
    chartOrientation: horizontal
  dataLabels:
    enabled: true
    placement: end
---
xychart-beta
title "Third-place Overperformance"
x-axis ["THIRUVAIYARU", "COLACHAL", "NAGERCOIL", "UDHAGAMANDALAM", "POLUR"]
y-axis "Overperformance %" 0 --> 25
bar [6.34, 4.74, 4.08, 2.10, 1.97]
```
