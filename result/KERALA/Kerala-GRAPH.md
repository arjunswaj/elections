# Table of contents

- [Analysis of Kerala Assembly Elections May 2026](#analysis-of-kerala-assembly-elections-may-2026)
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
     * [Communist Party of India (Marxist)](#communist-party-of-india-marxist)
     * [Communist Party of India](#communist-party-of-india)
     * [Indian National Congress](#indian-national-congress)
     * [Indian Union Muslim League](#indian-union-muslim-league)
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of Kerala Assembly Elections May 2026

The 2026 Kerala Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting overseen by the Election Commission of India soon after polling.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/KERALA).

## Analysis
A total of 883 candidates contested in the Kerala assembly elections and about 2.15 Crore (`21595055`) votes were cast during this period.

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
x-axis ["Independent", "BJP", "INC", "CPI(M)", "BSP", "Aam Aadmi Party", "Social Democratic Party Of India", "Socialist Unity Centre Of India (COMMUNIST)", "IUML", "CPI"]
y-axis "Number of Seats" 0 --> 338
bar [282, 98, 92, 77, 55, 53, 34, 30, 26, 24]
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
x-axis ["P.K KUNHALIKUTTY (IUML, MALAPPURAM)", "A.P ANILKUMAR (INC, WANDOOR)", "PROF. ABID HUSSAIN THANGAL (IUML, KOTTAKKAL)", "T.P. ASHRAFALI (IUML, KONDOTTY)", "ADV. M. RAHMATHULLA (IUML, MANJERI)"]
y-axis "Number of Votes" 102259 --> 144795
bar [131632, 121074, 118111, 114997, 113622]
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
x-axis ["C P JOHN (Communist Marxist Party Kerala State Committee, TH", "V. MURALEEDHARAN (BJP, KAZHAKOOTTAM)", "K. MURALEEDHARAN (INC, VATTIYOORKAVU)", "F. RAJA (INC, DEVIKULAM)", "ADV.K JAYANTH (INC, KOZHIKODE NORTH)"]
y-axis "Number of Votes" 41027 --> 55699
bar [45586, 46564, 48338, 50590, 50636]
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
x-axis ["V.ABDURAHIMAN (CPI(M), TIRUR)", "P K SHYAMALA TEACHER (CPI(M), TALIPARAMBA)", "DR. V P P MUSTAFA (CPI(M), TRIKARIPUR)", "ADV. P T A RAHIM (Independent, KUNNAMANGALAM)", "ADV. K.M. SACHINDEV (CPI(M), BALUSSERI)"]
y-axis "Number of Votes" 70041 --> 90168
bar [81971, 78788, 78678, 78285, 77824]
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
x-axis ["MANALUR (PROF C RAVINDRANATH, KERALA)", "AZHIKODE (K. V. SUMESH, KERALA)", "KAZHAKOOTTAM (V. MURALEEDHARAN, KERALA)", "KOTTARAKKARA (K.N. BALAGOPAL, KERALA)", "KUTHUPARAMBA (P K PRAVEEN, KERALA)"]
y-axis "Vote Difference" 62245 --> 71732
bar [65211, 64602, 46136, 62914, 69162]
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
x-axis ["KONDOTTY (T.P. ASHRAFALI, KERALA)", "MANJERI (ADV. M. RAHMATHULLA, KERALA)", "KOTTAKKAL (PROF. ABID HUSSAIN THANGAL, KERALA)", "TIRURANGADI (P M A SAMEER, KERALA)", "MALAPPURAM (P.K KUNHALIKUTTY, KERALA)"]
y-axis "Vote Difference" 0 --> 55566
bar [58980, 55735, 55473, 48482, 46305]
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
x-axis ["KUNNAMANGALAM (KERALA)", "WANDOOR (KERALA)", "TIRUR (KERALA)", "MALAPPURAM (KERALA)", "TALIPARAMBA (KERALA)"]
y-axis "Total Votes" 172957 --> 229843
bar [208949, 203168, 198509, 196885, 192175]
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
x-axis ["THIRUVANANTHAPURAM (KERALA)", "KOTTAYAM (KERALA)", "KUTTANAD (KERALA)", "DEVIKULAM (KERALA)", "ERANAKULAM (KERALA)"]
y-axis "Total Votes" 108439 --> 118505
bar [120488, 113747, 112560, 112135, 107732]
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
x-axis ["KODUVALLY (KERALA)", "PERAVOOR (KERALA)", "MANJESHWAR (KERALA)", "THIRUVANANTHAPURAM (KERALA)", "KOZHIKODE NORTH (KERALA)"]
y-axis "Number of Candidates" 0 --> 16
bar [14, 12, 12, 12, 11]
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
x-axis ["KOZHIKODE SOUTH (KERALA)", "NATTIKA (KERALA)", "MANANTHAVADY (KERALA)", "KAYAMKULAM (KERALA)", "CHAVARA (KERALA)"]
y-axis "Number of Candidates" 0 --> 10
bar [4, 4, 4, 4, 4]
```

#### Total Vote Share of Parties

```mermaid
pie title Total Vote Share of Parties
  "INC" : 28.79
  "CPI(M)" : 21.77
  "BJP" : 11.42
  "IUML" : 11.01
  "CPI" : 6.64
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
x-axis ["P.K KUNHALIKUTTY (IUML, MALAPPURAM)", "ADV. CHANDY OOMMEN (INC, PUTHUPPALLY)", "P M A SAMEER (IUML, TIRURANGADI)", "PROF. ABID HUSSAIN THANGAL (IUML, KOTTAKKAL)", "DR. MATHEW KUZHALNADAN (INC, MUVATTUPUZHA)"]
y-axis "Vote Share" 55.70 --> 71.86
bar [66.86, 65.56, 63.48, 61.77, 60.70]
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
x-axis ["V. MURALEEDHARAN (BJP, KAZHAKOOTTAM)", "ADV.K JAYANTH (INC, KOZHIKODE NORTH)", "K. MURALEEDHARAN (INC, VATTIYOORKAVU)", "MANI C KAPPEN (Independent, PALA)", "GEETHAGOPI (CPI, NATTIKA)"]
y-axis "Vote Share" 30.39 --> 42.44
bar [35.39, 35.78, 37.25, 37.39, 37.44]
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
x-axis ["DR. V P P MUSTAFA (CPI(M), TRIKARIPUR)", "LINTO JOSEPH (CPI(M), THIRUVAMBADI)", "T. P. RAMAKRISHNAN (CPI(M), PERAMBRA)", "T. I. MADHUSOODANAN (CPI(M), PAYYANNUR)", "K B GANESH KUMAR (Kerala Congress (B), PATHANAPURAM)"]
y-axis "Vote Share" 38.57 --> 51.04
bar [46.04, 44.93, 44.36, 44.34, 43.57]
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
x-axis ["Independent", "NOTA", "BJP", "BSP", "Aam Aadmi Party"]
y-axis "Number of Seats" 0 --> 310
bar [259, 140, 59, 55, 53]
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
x-axis ["INC", "CPI(M)", "IUML", "CPI", "Kerala Congress"]
y-axis "Number of Seats" 0 --> 75
bar [63, 26, 22, 8, 7]
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
x-axis ["CPI(M)", "INC", "Independent", "CPI", "Kerala Congress (M)"]
y-axis "Number of Seats" 0 --> 60
bar [50, 25, 16, 16, 12]
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
x-axis ["IUML", "Kerala Congress (Jacob)", "Revolutionary Marxist Party of India", "INC", "Kerala Congress"]
y-axis "Cost per Vote" 0 --> 73
bar [43.73, 44.67, 57.05, 59.18, 60.91]
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
x-axis ["Rashtravadi Janata Party", "Janam Rashtriya Party", "Socialist Party (India)", "Indian Gandhiyan Party", "The Future India Party"]
y-axis "Cost per Vote" 0 --> 90566
bar [29197.08, 32000.00, 32000.00, 33898.31, 75471.70]
```

#### Success Ratio - Best


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Communist Party of India (Marxist) | 77 | 26 | 33.76623376623376623400 |
| Communist Party of India | 24 | 8 | 33.33333333333333333300 |
| Rashtriya Janata Dal | 3 | 1 | 33.33333333333333333300 |
| Independent | 106 | 4 | 3.77358490566037735800 |
| Bharatiya Janata Party | 98 | 3 | 3.06122448979591836700 |

#### Success Ratio - Worst


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Bharatiya Janata Party | 98 | 3 | 3.06122448979591836700 |
| Independent | 106 | 4 | 3.77358490566037735800 |
| Communist Party of India | 24 | 8 | 33.33333333333333333300 |
| Rashtriya Janata Dal | 3 | 1 | 33.33333333333333333300 |
| Communist Party of India (Marxist) | 77 | 26 | 33.76623376623376623400 |

### Multiple Seat Participation

#### Results of Candidates participating in multiple seats

| Candidate | Constituency | Code | Party | Result |
| --- | --- | --- | --- | --- |

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

| Losing Party | < 500 | < 2500 | < 5000 | < 10000 | < 15000 | < 25000 | < 50000 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Bharatiya Janata Party | 0 | 0 | 0 | 0 | 3 | 5 | 6 |
| Communist Party of India | 0 | 2 | 3 | 5 | 6 | 9 | 15 |
| Communist Party of India (Marxist) | 1 | 2 | 6 | 17 | 25 | 39 | 46 |
| Congress (Secular) | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
| Independent | 0 | 0 | 0 | 2 | 4 | 5 | 13 |
| Indian National Congress | 1 | 4 | 8 | 14 | 18 | 25 | 25 |
| Indian National League | 0 | 0 | 0 | 0 | 1 | 1 | 1 |
| Indian Socialist Janata Dal | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
| Indian Union Muslim League | 1 | 3 | 3 | 3 | 3 | 4 | 4 |
| Kerala Congress | 0 | 0 | 0 | 0 | 0 | 1 | 1 |

#### Party Specific Close Contest Matrix


##### Communist Party of India (Marxist)

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| KAZHAKOOTTAM | S11132 | 46136 | Bharatiya Janata Party | 46564 | 428 |
| KOZHIKODE NORTH | S1127 | 49153 | Indian National Congress | 50636 | 1483 |
| KONGAD | S1153 | 59028 | Indian National Congress | 62734 | 3706 |
| TRIKARIPUR | S115 | 78678 | Indian National Congress | 83109 | 4431 |
| UDMA | S113 | 74063 | Indian National Congress | 78910 | 4847 |


##### Communist Party of India

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| VAIKOM | S1195 | 51584 | Indian National Congress | 52944 | 1360 |
| CHIRAYINKEEZHU | S11129 | 55411 | Indian National Congress | 56833 | 1422 |
| CHATHANNOOR | S11126 | 47525 | Bharatiya Janata Party | 51923 | 4398 |
| CHADAYAMANGALAM | S11122 | 60795 | Indian National Congress | 68281 | 7486 |
| KODUNGALLUR | S1173 | 56854 | Indian National Congress | 65162 | 8308 |


##### Indian National Congress

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| MANALUR | S1164 | 65211 | Communist Party of India (Marxist) | 65337 | 126 |
| KOTTARAKKARA | S11119 | 62914 | Communist Party of India (Marxist) | 63926 | 1012 |
| KONNI | S11114 | 58542 | Communist Party of India (Marxist) | 60380 | 1838 |
| VARKALA | S11127 | 53315 | Communist Party of India (Marxist) | 55365 | 2050 |
| ARUVIKKARA | S11136 | 59064 | Communist Party of India (Marxist) | 61907 | 2843 |


##### Indian Union Muslim League

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| AZHIKODE | S1110 | 64602 | Communist Party of India (Marxist) | 64951 | 349 |
| KUTHUPARAMBA | S1114 | 69162 | Rashtriya Janata Dal | 70448 | 1286 |
| GURUVAYOOR | S1163 | 64071 | Communist Party of India (Marxist) | 66069 | 1998 |
| PUNALUR | S11121 | 50415 | Communist Party of India | 71944 | 21529 |


### Advanced Join Insights

#### Crowding pressure seats

Crowded ballots with thin margins are visualized below using "others" vote share as a proxy for fragmentation.

| Code | Constituency | Winning Party | Runner Up Party | Candidate Count | Others Vote % | Margin Votes | Margin % | Postal Gap | Crowding Band |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S11134 | THIRUVANANTHAPURAM | Communist Marxist Party Kerala State Committee | Independent | 12 | 32.51 | 9863 | 8.18 | 254 | Crowded |
| S11133 | VATTIYOORKAVU | Indian National Congress | Communist Party of India (Marxist) | 9 | 29.68 | 5425 | 4.18 | 259 | Standard |
| S1168 | NATTIKA | Communist Party of India | Indian National Congress | 4 | 29.62 | 7093 | 4.50 | 69 | Standard |
| S11132 | KAZHAKOOTTAM | Bharatiya Janata Party | Communist Party of India (Marxist) | 8 | 29.56 | 428 | 0.33 | -184 | Standard |
| S1127 | KOZHIKODE NORTH | Indian National Congress | Communist Party of India (Marxist) | 11 | 29.49 | 1483 | 1.05 | -13 | Crowded |

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
x-axis ["THIRUVANANTHAPURAM", "VATTIYOORKAVU", "NATTIKA", "KAZHAKOOTTAM", "KOZHIKODE NORTH"]
y-axis "Others Vote %" 0 --> 50
bar [32.51, 29.68, 29.62, 29.56, 29.49]
```

#### Runner-up overperformance vs party baseline

These runner-up candidates beat their party-wide average vote share even in defeat.

| Constituency | Candidate | Party | Runner Up % | Party Avg % | Overperformance % | Constituencies |
| --- | --- | --- | --- | --- | --- | --- |
| BEYPORE | P V ANVAR S/O SHOUKATHALI | Independent | 40.16 | 3.00 | 37.16 | 282 |
| THAVANUR | DR. K T JALEEL | Independent | 39.67 | 3.00 | 36.67 | 282 |
| CHAVARA | DR.SUJITH VIJAYANPILLAI | Independent | 39.16 | 3.00 | 36.16 | 282 |
| VENGARA | SABAH KUNDUPUZHAKKAL | Independent | 38.49 | 3.00 | 35.49 | 282 |
| TANUR | MOHAMED SAMEER T THIRUTHIYIL HOUSE | Independent | 37.64 | 3.00 | 34.64 | 282 |

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
x-axis ["BEYPORE", "THAVANUR", "CHAVARA", "VENGARA", "TANUR"]
y-axis "Overperformance %" 0 --> 35
bar [37.16, 36.67, 36.16, 35.49, 34.64]
```

#### HHI win mix by party

Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types.

| Party | HHI Band | Seats Won |
| --- | --- | --- |
| Bharatiya Janata Party | Fragmented | 3 |
| Communist Marxist Party Kerala State Committee | Fragmented | 1 |
| Communist Party of India | Competitive | 6 |
| Communist Party of India | Fragmented | 2 |
| Communist Party of India (Marxist) | Competitive | 20 |
| Communist Party of India (Marxist) | Fragmented | 6 |
| Independent | Competitive | 3 |
| Independent | Fragmented | 1 |
| Indian National Congress | Competitive | 48 |
| Indian National Congress | Dominant | 8 |

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
bar "Independent" [3, 0, 1]
bar "Revolutionary" [0, 0, 0]
bar "Revolutionary" [0, 0, 0]
bar "Rashtriya" [0, 0, 0]
bar "Kerala" [0, 0, 0]
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
x-axis ["THIRUVANANTHAPURAM", "NATTIKA", "VATTIYOORKAVU", "KOZHIKODE NORTH", "KATTAKKADA"]
y-axis "Overperformance %" 0 --> 25
bar [12.69, 12.24, 12.22, 11.73, 9.68]
```
