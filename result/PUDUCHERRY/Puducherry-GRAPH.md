# Table of contents

- [Analysis of Puducherry Assembly Elections May 2026](#analysis-of-puducherry-assembly-elections-may-2026)
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
     * [All India N.R. Congress](#all-india-nr-congress)
     * [Bharatiya Janata Party](#bharatiya-janata-party)
     * [Dravida Munnetra Kazhagam](#dravida-munnetra-kazhagam)
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of Puducherry Assembly Elections May 2026

The 2026 Puducherry Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting overseen by the Election Commission of India soon after polling.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/PUDUCHERRY).

## Analysis
A total of 294 candidates contested in the Puducherry assembly elections and about .08 Crore (`866139`) votes were cast during this period.

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
x-axis ["Independent", "NTK", "TVK", "INC", "PMK", "AINRC", "DMK", "BJP", "Tamilaga Makkal Thannurimai Katchi", "Naadaalum Makkal Katchi"]
y-axis "Number of Seats" 0 --> 140
bar [117, 28, 28, 22, 19, 16, 13, 10, 8, 5]
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
x-axis ["MALLADI KRISHNA RAO (AINRC, YANAM)", "N. RANGASAMY (AINRC, MANGALAM)", "B.RAVICOUMAR (AINRC, VILLIANUR)", "G.N.S. RAJASEKARAN (BJP, THIRUNALLAR)", "JOSE CHARLES MARTIN (Latchiya Jananayaka Katchi (LJK), KAMAR"]
y-axis "Number of Votes" 14932 --> 21849
bar [19863, 17917, 16970, 16829, 16592]
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
x-axis ["VIGNESH KANNAN (DMK, RAJ BHAVAN)", "V. CARTIGUEYANE (DMK, NELLITHOPE)", "ADV. T. ASHOK KUMAR (Independent, MAHE)", "VAIYAPURI MANIKANDAN (AINRC, MUTHIALPET)", "A ANBALAGAN (AIADMK, OUPALAM)"]
y-axis "Number of Votes" 6573 --> 10008
bar [7304, 8226, 8375, 8382, 9099]
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
x-axis ["GOLLAPALLI SRINIVAS ASHOK (INC, YANAM)", "R.SIVA (DMK, VILLIANUR)", "VIZAYALAKSHMY DJEAMOURTHY (INC, ARIANKUPPAM)", "S. MOUROUGANE (TVK, INDIRA NAGAR)", "M. CANDASSAMY (INC, EMBALAM)"]
y-axis "Number of Votes" 10760 --> 16824
bar [15295, 15000, 13607, 12056, 11956]
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
x-axis ["VIGNESH KANNAN (DMK, RAJ BHAVAN)", "SENTHIL @ RAMESH (DMK, KALAPET)", "P.V. AROUMOUGAME @ AKD (AINRC, INDIRA NAGAR)", "C. AIYAPPAN @ MOUTTAYAPPAN (AINRC, ARIANKUPPAM)", "AK. SAI J SARAVANAN KUMAR (TVK, THIRUBHUVANAI)"]
y-axis "Vote Difference" 630 --> 315
bar [287, 447, 584, 603, 701]
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
x-axis ["P. RAJAVELU (AINRC, NETTAPAKKAM)", "AZHAGU @ AZHAGANANTHAM (Independent, KADIRGAMAM)", "N. RANGASAMY (AINRC, MANGALAM)", "G.N.S. RAJASEKARAN (BJP, THIRUNALLAR)", "JOSE CHARLES MARTIN (Latchiya Jananayaka Katchi (LJK), KAMAR"]
y-axis "Vote Difference" 0 --> 12246
bar [6689, 7004, 7050, 9526, 10205]
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
x-axis ["VILLIANUR (PUDUCHERRY)", "OZHUKARAI (PUDUCHERRY)", "YANAM (PUDUCHERRY)", "MANGALAM (PUDUCHERRY)", "ARIANKUPPAM (PUDUCHERRY)"]
y-axis "Total Votes" 31059 --> 43280
bar [39346, 35893, 35826, 35405, 34510]
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
x-axis ["THATTANCHAVADY (PUDUCHERRY)", "MUTHIALPET (PUDUCHERRY)", "OUPALAM (PUDUCHERRY)", "ORLEAMPETH (PUDUCHERRY)", "RAJ BHAVAN (PUDUCHERRY)"]
y-axis "Total Votes" 21220 --> 20587
bar [23578, 23560, 23030, 19594, 18716]
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
x-axis ["MUDALIARPET (PUDUCHERRY)", "NETTAPAKKAM (PUDUCHERRY)", "NELLITHOPE (PUDUCHERRY)", "OZHUKARAI (PUDUCHERRY)", "YANAM (PUDUCHERRY)"]
y-axis "Number of Candidates" 0 --> 18
bar [15, 15, 15, 15, 14]
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
x-axis ["KALAPET (PUDUCHERRY)", "RAJ BHAVAN (PUDUCHERRY)", "OUPALAM (PUDUCHERRY)", "NEDUNGADU (PUDUCHERRY)", "OUSSUDU (PUDUCHERRY)"]
y-axis "Number of Candidates" 0 --> 12
bar [8, 8, 7, 7, 6]
```

#### Total Vote Share of Parties

```mermaid
pie title Total Vote Share of Parties
  "AINRC" : 23.12
  "INC" : 17.54
  "TVK" : 16.72
  "DMK" : 13.74
  "BJP" : 12.19
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
x-axis ["G.N.S. RAJASEKARAN (BJP, THIRUNALLAR)", "MALLADI KRISHNA RAO (AINRC, YANAM)", "A. NAMASSIVAYAM (BJP, MANNADIPET)", "JOSE CHARLES MARTIN (Latchiya Jananayaka Katchi (LJK), KAMAR", "AZHAGU @ AZHAGANANTHAM (Independent, KADIRGAMAM)"]
y-axis "Vote Share" 46.35 --> 65.18
bar [60.18, 55.44, 53.96, 53.14, 51.35]
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
x-axis ["AK. SAI J SARAVANAN KUMAR (TVK, THIRUBHUVANAI)", "V. CARTIGUEYANE (DMK, NELLITHOPE)", "ADV. T. ASHOK KUMAR (Independent, MAHE)", "K.NARAYANASAMY ALIAS NITHYANANDAM (AINRC, OZHUKARAI)", "VAIYAPURI MANIKANDAN (AINRC, MUTHIALPET)"]
y-axis "Vote Share" 27.15 --> 40.58
bar [32.15, 33.21, 35.19, 35.20, 35.58]
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
x-axis ["S. GOPAL (DMK, ORLEAMPETH)", "GOLLAPALLI SRINIVAS ASHOK (INC, YANAM)", "S. MOUROUGANE (TVK, INDIRA NAGAR)", "VIZAYALAKSHMY DJEAMOURTHY (INC, ARIANKUPPAM)", "R.SIVA (DMK, VILLIANUR)"]
y-axis "Vote Share" 33.12 --> 49.70
bar [44.70, 42.69, 40.19, 39.43, 38.12]
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
x-axis ["Independent", "NOTA", "NTK", "PMK", "TVK"]
y-axis "Number of Seats" 0 --> 133
bar [111, 30, 28, 19, 15]
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
x-axis ["AINRC", "DMK", "BJP", "Independent", "TVK"]
y-axis "Number of Seats" 0 --> 14
bar [12, 5, 4, 3, 2]
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
x-axis ["INC", "DMK", "BJP", "AINRC", "TVK"]
y-axis "Number of Seats" 0 --> 14
bar [12, 5, 4, 4, 3]
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
x-axis ["AINRC", "BJP", "Latchiya Jananayaka Katchi (LJK)", "DMK", "Neyam Makkal Kazhagam"]
y-axis "Cost per Vote" 0 --> 617
bar [319.53, 378.85, 401.95, 436.84, 514.70]
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
x-axis ["Aanaithinthiya Jananayaka Pathukappu Kazhagam", "Anna Makkal Katchi", "Desa Makkal Munnetrak Kazhagam", "Parivartan Rajniti Party", "Rashtriya Samaj Dal (R)"]
y-axis "Cost per Vote" 0 --> 204255
bar [95238.10, 102564.10, 117647.06, 166666.67, 170212.77]
```

#### Success Ratio - Best


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Bharatiya Janata Party | 10 | 4 | 40.00000000000000000000 |
| Dravida Munnetra Kazhagam | 13 | 5 | 38.46153846153846153800 |
| Independent | 28 | 3 | 10.71428571428571428600 |
| Tamilaga Vettri Kazhagam | 28 | 2 | 7.14285714285714285700 |
| Indian National Congress | 22 | 1 | 4.54545454545454545500 |

#### Success Ratio - Worst


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Indian National Congress | 22 | 1 | 4.54545454545454545500 |
| Tamilaga Vettri Kazhagam | 28 | 2 | 7.14285714285714285700 |
| Independent | 28 | 3 | 10.71428571428571428600 |
| Dravida Munnetra Kazhagam | 13 | 5 | 38.46153846153846153800 |
| Bharatiya Janata Party | 10 | 4 | 40.00000000000000000000 |

### Multiple Seat Participation

#### Results of Candidates participating in multiple seats

| Candidate | Constituency | Code | Party | Result |
| --- | --- | --- | --- | --- |
| N. RANGASAMY | MANGALAM | U074 | All India N.R. Congress | WON |
| N. RANGASAMY | THATTANCHAVADY | U079 | All India N.R. Congress | WON |
| RAMESH | MAHE | U0729 | Independent | LOST |
| RAMESH | KADIRGAMAM | U077 | Independent | LOST |

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

| Losing Party | < 500 | < 2500 | < 5000 | < 10000 | < 15000 | < 25000 | < 50000 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| All India N.R. Congress | 0 | 2 | 3 | 4 | 4 | 4 | 4 |
| Bharatiya Janata Party | 2 | 2 | 4 | 4 | 4 | 4 | 4 |
| Dravida Munnetra Kazhagam | 0 | 4 | 4 | 5 | 5 | 5 | 5 |
| Independent | 0 | 1 | 1 | 1 | 1 | 1 | 1 |
| Indian National Congress | 0 | 4 | 7 | 11 | 12 | 12 | 12 |
| Neyam Makkal Kazhagam | 0 | 0 | 1 | 1 | 1 | 1 | 1 |
| Tamilaga Vettri Kazhagam | 0 | 2 | 3 | 3 | 3 | 3 | 3 |

#### Party Specific Close Contest Matrix


##### All India N.R. Congress

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| THIRUBHUVANAI | U072 | 9039 | Tamilaga Vettri Kazhagam | 9740 | 701 |
| BAHOUR | U0723 | 8123 | Dravida Munnetra Kazhagam | 10520 | 2397 |
| NEDUNGADU | U0724 | 9869 | Independent | 14368 | 4499 |
| KADIRGAMAM | U077 | 7629 | Independent | 14633 | 7004 |


##### Bharatiya Janata Party

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| RAJ BHAVAN | U0714 | 7017 | Dravida Munnetra Kazhagam | 7304 | 287 |
| KALAPET | U0712 | 11622 | Dravida Munnetra Kazhagam | 12069 | 447 |
| MANAVELY | U0720 | 10729 | Tamilaga Vettri Kazhagam | 13822 | 3093 |
| OUSSUDU | U073 | 11382 | Indian National Congress | 15400 | 4018 |


##### Dravida Munnetra Kazhagam

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| ORLEAMPETH | U0716 | 8759 | Neyam Makkal Kazhagam | 9960 | 1201 |
| VILLIANUR | U075 | 15000 | All India N.R. Congress | 16970 | 1970 |
| NERAVY-T.R.PATTINAM | U0728 | 8800 | Bharatiya Janata Party | 10818 | 2018 |
| MUDALIARPET | U0718 | 10574 | Bharatiya Janata Party | 12945 | 2371 |
| MANGALAM | U074 | 10867 | All India N.R. Congress | 17917 | 7050 |


### Advanced Join Insights

#### Crowding pressure seats

Crowded ballots with thin margins are visualized below using "others" vote share as a proxy for fragmentation.

| Code | Constituency | Winning Party | Runner Up Party | Candidate Count | Others Vote % | Margin Votes | Margin % | Postal Gap | Crowding Band |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| U076 | OZHUKARAI | All India N.R. Congress | Tamilaga Vettri Kazhagam | 15 | 41.37 | 4234 | 11.79 | 180 | Ultra-crowded |
| U072 | THIRUBHUVANAI | Tamilaga Vettri Kazhagam | All India N.R. Congress | 12 | 38.02 | 701 | 2.32 | -69 | Crowded |
| U0717 | NELLITHOPE | Dravida Munnetra Kazhagam | Independent | 15 | 37.02 | 850 | 3.43 | 57 | Ultra-crowded |
| U0729 | MAHE | Independent | Indian National Congress | 9 | 34.30 | 1115 | 4.69 | -12 | Standard |
| U079 | THATTANCHAVADY | All India N.R. Congress | Neyam Makkal Kazhagam | 11 | 33.80 | 4441 | 18.83 | 176 | Crowded |

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
x-axis ["OZHUKARAI", "THIRUBHUVANAI", "NELLITHOPE", "MAHE", "THATTANCHAVADY"]
y-axis "Others Vote %" 0 --> 50
bar [41.37, 38.02, 37.02, 34.30, 33.80]
```

#### Runner-up overperformance vs party baseline

These runner-up candidates beat their party-wide average vote share even in defeat.

| Constituency | Candidate | Party | Runner Up % | Party Avg % | Overperformance % | Total Constituencies Contested |
| --- | --- | --- | --- | --- | --- | --- |
| NELLITHOPE | OMSAKTHISEKAR | Independent | 29.78 | 2.33 | 27.45 | 117 |
| INDIRA NAGAR | S. MOUROUGANE | Tamilaga Vettri Kazhagam | 40.19 | 17.60 | 22.59 | 28 |
| YANAM | GOLLAPALLI SRINIVAS ASHOK | Indian National Congress | 42.69 | 23.35 | 19.34 | 22 |
| OUPALAM | S SIVA | Tamilaga Vettri Kazhagam | 35.05 | 17.60 | 17.45 | 28 |
| ARIANKUPPAM | VIZAYALAKSHMY DJEAMOURTHY | Indian National Congress | 39.43 | 23.35 | 16.08 | 22 |

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
x-axis ["NELLITHOPE", "INDIRA NAGAR", "YANAM", "OUPALAM", "ARIANKUPPAM"]
y-axis "Overperformance %" 0 --> 35
bar [27.45, 22.59, 19.34, 17.45, 16.08]
```

#### HHI win mix by party

Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types.

| Party | HHI Band | Seats Won |
| --- | --- | --- |
| All India Anna Dravida Munnetra Kazhagam | Fragmented | 1 |
| All India N.R. Congress | Competitive | 3 |
| All India N.R. Congress | Dominant | 1 |
| All India N.R. Congress | Fragmented | 8 |
| Bharatiya Janata Party | Competitive | 2 |
| Bharatiya Janata Party | Fragmented | 2 |
| Dravida Munnetra Kazhagam | Fragmented | 5 |
| Independent | Competitive | 2 |
| Independent | Fragmented | 1 |
| Indian National Congress | Competitive | 1 |

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
bar "Independent" [2, 0, 1]
bar "Tamilaga" [0, 0, 0]
bar "Neyam" [0, 0, 0]
bar "Latchiya" [0, 0, 0]
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
x-axis ["OZHUKARAI", "THATTANCHAVADY", "BAHOUR", "NERAVY-T.R.PATTINAM", "LAWSPET"]
y-axis "Overperformance %" 0 --> 25
bar [18.41, 14.57, 11.69, 10.09, 3.50]
```
