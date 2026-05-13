# Table of contents

- [Analysis of Assam Assembly Elections May 2026](#analysis-of-assam-assembly-elections-may-2026)
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
     * [All India United Democratic Front](#all-india-united-democratic-front)
     * [Asom Gana Parishad](#asom-gana-parishad)
     * [Bharatiya Janata Party](#bharatiya-janata-party)
     * [Indian National Congress](#indian-national-congress)
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of Assam Assembly Elections May 2026

The 2026 Assam Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting overseen by the Election Commission of India soon after polling.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/ASSAM).

## Analysis
A total of 722 candidates contested in the Assam assembly elections and about 2.16 Crore (`21665618`) votes were cast during this period.

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
x-axis ["Independent", "INC", "BJP", "Socialist Unity Centre Of India (COMMUNIST)", "AIUDF", "AGP", "AITC", "Aam Aadmi Party", "United Peoples Party Liberal", "Voters Party International"]
y-axis "Number of Seats" 0 --> 309
bar [258, 99, 90, 41, 30, 26, 22, 18, 18, 17]
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
x-axis ["ABDUS SOBAHAN ALI SARKAR (INC, GAURIPUR)", "DR ASIF MOHAMMAD NAZAR (INC, LAHARIGHAT)", "Mohibur Rohman (Bappy) (INC, MANKACHAR)", "AFTAB UDDIN MOLLAH (INC, JALESHWAR)", "JAKIR HUSSAIN SIKDAR (INC, PAKABETBARI)"]
y-axis "Number of Votes" 141973 --> 201268
bar [182971, 169212, 169036, 162174, 157748]
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
x-axis ["SABHARAM BASUMATARY (BPF, GOSSAIGAON)", "RABIRAM NARZARY (BPF, DOTMA)", "HABBEY TERON (BJP, AMRI)", "RUPAM CHANDRA ROY (BPF, BAOKHUNGRI)", "SUREN PHUKAN (BJP, DIGBOI)"]
y-axis "Number of Votes" 39954 --> 72259
bar [44394, 48775, 50273, 62677, 65690]
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
x-axis ["MD AYNUL HOQUE (Independent, DALGAON)", "ZABED ISLAM (AGP, MANKACHAR)", "SIDDIQUE AHMED (AIUDF, LAHARIGHAT)", "SUBRATA BHATTACHARJEE (BJP, KARIMGANJ NORTH)", "SWAPAN KAR (INC, LUMDING)"]
y-axis "Number of Votes" 83894 --> 130542
bar [118675, 115890, 102917, 96353, 93216]
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
x-axis ["PRAKASH CHANDRA DAS (AGP, HAJO-SUALKUCHI)", "JIBESH ROY (AGP, BILASIPARA)", "BHUPEN KUMAR BORAH (BJP, BIHPURIA)", "MD ASHRAFUL ISLAM SHEIKH (INC, PARBATJHORA)", "CHAKRADHAR GOGOI (BJP, KHOWANG)"]
y-axis "Vote Difference" 8985 --> 796
bar [724, 2694, 8236, 9022, 9984]
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
x-axis ["KAUSHIK RAI (BJP, LAKHIPUR)", "ZUBAIR ANAM MAZUMDER (INC, ALGAPUR-KATLICHERRA)", "TANZIL HUSSAIN (INC, SAMAGURI)", "AFTAB UDDIN MOLLAH (INC, JALESHWAR)", "ABDUS SOBAHAN ALI SARKAR (INC, GAURIPUR)"]
y-axis "Vote Difference" 0 --> 142916
bar [99401, 105448, 108310, 109688, 119097]
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
x-axis ["DALGAON (ASSAM)", "GAURIPUR (ASSAM)", "MANKACHAR (ASSAM)", "LAHARIGHAT (ASSAM)", "BIRSING JARUA (ASSAM)"]
y-axis "Total Votes" 246836 --> 334673
bar [304249, 299353, 298796, 292863, 274263]
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
x-axis ["DIGBOI (ASSAM)", "RONGKHANG (ASSAM)", "GOSSAIGAON (ASSAM)", "DOTMA (ASSAM)", "AMRI (ASSAM)"]
y-axis "Total Votes" 105074 --> 87380
bar [116749, 109939, 100093, 94274, 79437]
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
x-axis ["KARIMGANJ SOUTH (ASSAM)", "ALGAPUR-KATLICHERRA (ASSAM)", "KATIGORAH (ASSAM)", "GOALPARA EAST (ASSAM)", "GORESWAR (ASSAM)"]
y-axis "Number of Candidates" 0 --> 19
bar [16, 16, 15, 15, 15]
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
x-axis ["TEOK (ASSAM)", "DOOMDOOMA (ASSAM)", "MAHMORA (ASSAM)", "JAGIROAD (ASSAM)", "LAKHIPUR (ASSAM)"]
y-axis "Number of Candidates" 0 --> 10
bar [3, 3, 3, 3, 3]
```

#### Total Vote Share of Parties

```mermaid
pie title Total Vote Share of Parties
  "BJP" : 37.81
  "INC" : 29.84
  "AGP" : 6.47
  "AIUDF" : 5.46
  "Independent" : 4.37
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
x-axis ["KAUSHIK RAI (BJP, LAKHIPUR)", "TULIRAM RONGHANG (BJP, RONGKHANG)", "HIMANTA BISWA SARMA (BJP, JALUKBARI)", "BHUBON PEGU (BJP, JONAI)", "RUPESH GOWALA (BJP, DOOMDOOMA)"]
y-axis "Vote Share" 65.79 --> 86.49
bar [81.49, 75.72, 74.42, 71.57, 70.79]
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
x-axis ["WAZED ALI CHOUDHURY (INC, BIRSING JARUA)", "RUPAM CHANDRA ROY (BPF, BAOKHUNGRI)", "SHERMAN ALI AHMED (AITC, MANDIA)", "ARUP KUMAR DEY (BJP, BIJNI)", "SABHARAM BASUMATARY (BPF, GOSSAIGAON)"]
y-axis "Vote Share" 36.53 --> 49.35
bar [41.53, 41.95, 43.07, 43.44, 44.35]
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
x-axis ["NANDITA DAS (INC, HAJO-SUALKUCHI)", "AMRIT BADSHA (INC, BILASIPARA)", "NARAYAN BHUYAN (INC, BIHPURIA)", "UTPAL BANIA (INC, RAHA)", "LURINJYOTI GOGOI (AJP, KHOWANG)"]
y-axis "Vote Share" 38.15 --> 52.41
bar [47.41, 46.59, 46.15, 43.55, 43.15]
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
x-axis ["Independent", "NOTA", "Socialist Unity Centre Of India (COMMUNIST)", "AITC", "Aam Aadmi Party"]
y-axis "Number of Seats" 0 --> 297
bar [248, 126, 41, 20, 18]
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
x-axis ["BJP", "INC", "AGP", "BPF", "AIUDF"]
y-axis "Number of Seats" 0 --> 98
bar [82, 19, 10, 10, 2]
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
x-axis ["INC", "AIUDF", "AJP", "United Peoples Party Liberal", "Raijor Dal"]
y-axis "Number of Seats" 0 --> 82
bar [69, 11, 10, 9, 7]
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
x-axis ["BJP", "BPF", "INC", "AJP", "AGP"]
y-axis "Cost per Vote" 0 --> 88
bar [43.94, 54.49, 61.26, 73.31, 74.14]
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
x-axis ["Bharatiya Gana Parishad", "Socialist Unity Centre Of India (COMMUNIST)", "Rashtriya Ulama Council", "Apni Janta Party", "All India Forward Bloc"]
y-axis "Cost per Vote" 0 --> 15335
bar [4430.91, 5132.86, 6341.15, 12598.43, 12779.55]
```

#### Success Ratio - Best


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| Asom Gana Parishad | 26 | 10 | 38.46153846153846153800 |
| Indian National Congress | 99 | 19 | 19.19191919191919191900 |
| Raijor Dal | 13 | 2 | 15.38461538461538461500 |
| All India United Democratic Front | 30 | 2 | 6.66666666666666666700 |
| All India Trinamool Congress | 22 | 1 | 4.54545454545454545500 |

#### Success Ratio - Worst


| Party | Seats Contested | Seats Won | Success Ratio |
| --- | --- | --- | --- |
| All India Trinamool Congress | 22 | 1 | 4.54545454545454545500 |
| All India United Democratic Front | 30 | 2 | 6.66666666666666666700 |
| Raijor Dal | 13 | 2 | 15.38461538461538461500 |
| Indian National Congress | 99 | 19 | 19.19191919191919191900 |
| Asom Gana Parishad | 26 | 10 | 38.46153846153846153800 |

### Multiple Seat Participation

#### Results of Candidates participating in multiple seats

| Candidate | Constituency | Code | Party | Result |
| --- | --- | --- | --- | --- |
| MAZIBUR RAHMAN | DALGAON | S0351 | All India United Democratic Front | WON |
| MAZIBUR RAHMAN | BARHAMPUR | S0359 | All India United Democratic Front | LOST |
| NABA KUMAR SARANIA | BIJNI | S0320 | Gana Suraksha Party | LOST |
| NABA KUMAR SARANIA | MANAS | S0341 | Gana Suraksha Party | LOST |
| DHANJEEP PRASAD RABHA | GOALPARA WEST | S0313 | Independent | LOST |
| DHANJEEP PRASAD RABHA | GOALPARA EAST | S0314 | Independent | LOST |
| HEMANTA BORUAH | SIBSAGAR | S0396 | Independent | LOST |
| HEMANTA BORUAH | LAKHIMPUR | S0376 | Independent | LOST |
| RABINDRA RONGPI | HOWRAGHAT | S03109 | Independent | LOST |
| RABINDRA RONGPI | DIPHU | S03110 | Independent | LOST |

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

| Losing Party | < 500 | < 2500 | < 5000 | < 10000 | < 15000 | < 25000 | < 50000 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| All India United Democratic Front | 0 | 0 | 0 | 0 | 0 | 1 | 2 |
| Asom Gana Parishad | 0 | 0 | 0 | 0 | 0 | 1 | 2 |
| Assam Jatiya Parishad | 0 | 0 | 0 | 1 | 1 | 2 | 5 |
| Bharatiya Janata Party | 0 | 0 | 0 | 0 | 0 | 1 | 2 |
| Bodoland Peoples Front | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
| Communist Party of India (Marxist) | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| Independent | 0 | 0 | 0 | 0 | 0 | 2 | 5 |
| Indian National Congress | 0 | 1 | 2 | 3 | 4 | 18 | 45 |
| Jharkhand Mukti Morcha | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
| Raijor Dal | 0 | 0 | 0 | 0 | 0 | 1 | 5 |

#### Party Specific Close Contest Matrix


##### All India United Democratic Front

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| SRIJANGRAM | S0317 | 88411 | Indian National Congress | 106716 | 18305 |
| BIRSING JARUA | S039 | 78016 | Indian National Congress | 113901 | 35885 |


##### Asom Gana Parishad

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| NOWBOICHA | S0375 | 63230 | Indian National Congress | 86981 | 23751 |
| SONAI | S03119 | 62787 | Indian National Congress | 89957 | 27170 |


##### Bharatiya Janata Party

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| SIBSAGAR | S0396 | 69249 | Raijor Dal | 86521 | 17272 |
| KARIMGANJ NORTH | S03123 | 96353 | Indian National Congress | 122356 | 26003 |


##### Indian National Congress

| Constituency | Code | Runner Up Votes | Winning Party | Winning Votes | Vote Difference |
| --- | --- | --- | --- | --- | --- |
| HAJO-SUALKUCHI | S0330 | 80975 | Asom Gana Parishad | 81699 | 724 |
| BILASIPARA | S0310 | 83243 | Asom Gana Parishad | 85937 | 2694 |
| BIHPURIA | S0373 | 64814 | Bharatiya Janata Party | 73050 | 8236 |
| DULIAJAN | S0390 | 61008 | Bharatiya Janata Party | 71467 | 10459 |
| MAHMORA | S0394 | 53509 | Bharatiya Janata Party | 69530 | 16021 |


### Advanced Join Insights

#### Crowding pressure seats

Crowded ballots with thin margins are visualized below using "others" vote share as a proxy for fragmentation.

| Code | Constituency | Winning Party | Runner Up Party | Candidate Count | Others Vote % | Margin Votes | Margin % | Postal Gap | Crowding Band |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S035 | PARBATJHORA | Indian National Congress | Bodoland Peoples Front | 9 | 11.59 | 9022 | 5.49 | -319 | Standard |
| S0389 | KHOWANG | Bharatiya Janata Party | Assam Jatiya Parishad | 5 | 6.14 | 9984 | 7.55 | -72 | Standard |
| S0310 | BILASIPARA | Asom Gana Parishad | Indian National Congress | 7 | 5.31 | 2694 | 1.50 | 652 | Standard |
| S0330 | HAJO-SUALKUCHI | Asom Gana Parishad | Indian National Congress | 6 | 4.75 | 724 | 0.43 | 310 | Standard |
| S0373 | BIHPURIA | Bharatiya Janata Party | Indian National Congress | 5 | 1.85 | 8236 | 5.86 | 69 | Standard |

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
x-axis ["PARBATJHORA", "KHOWANG", "BILASIPARA", "HAJO-SUALKUCHI", "BIHPURIA"]
y-axis "Others Vote %" 0 --> 50
bar [11.59, 6.14, 5.31, 4.75, 1.85]
```

#### Runner-up overperformance vs party baseline

These runner-up candidates beat their party-wide average vote share even in defeat.

| Constituency | Candidate | Party | Runner Up % | Party Avg % | Overperformance % | Total Constituencies Contested |
| --- | --- | --- | --- | --- | --- | --- |
| DALGAON | MD AYNUL HOQUE | Independent | 39.01 | 2.09 | 36.92 | 258 |
| KALIABOR | JITEN GOUR | Independent | 34.20 | 2.09 | 32.11 | 258 |
| AMRI | BIKRAM HANSE | Independent | 33.19 | 2.09 | 31.10 | 258 |
| BARPETA | GAGAN CHANDRA HALOI | Independent | 31.20 | 2.09 | 29.11 | 258 |
| DIPHU | J. I  KATHAR | Independent | 28.49 | 2.09 | 26.40 | 258 |

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
x-axis ["DALGAON", "KALIABOR", "AMRI", "BARPETA", "DIPHU"]
y-axis "Overperformance %" 0 --> 35
bar [36.92, 32.11, 31.10, 29.11, 26.40]
```

#### HHI win mix by party

Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types.

| Party | HHI Band | Seats Won |
| --- | --- | --- |
| All India Trinamool Congress | Fragmented | 1 |
| All India United Democratic Front | Competitive | 2 |
| Asom Gana Parishad | Competitive | 4 |
| Asom Gana Parishad | Dominant | 5 |
| Asom Gana Parishad | Fragmented | 1 |
| Bharatiya Janata Party | Competitive | 18 |
| Bharatiya Janata Party | Dominant | 63 |
| Bharatiya Janata Party | Fragmented | 1 |
| Bodoland Peoples Front | Competitive | 5 |
| Bodoland Peoples Front | Dominant | 1 |

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
bar "Raijor" [0, 0, 0]
bar "Indian" [0, 0, 0]
bar "Bodoland" [0, 0, 0]
bar "Bharatiya" [0, 0, 0]
bar "Asom" [0, 0, 0]
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
x-axis ["KHOWANG", "BIHPURIA", "HAJO-SUALKUCHI", "PARBATJHORA", "BILASIPARA"]
y-axis "Overperformance %" 0 --> 25
bar [1.21, -0.45, -2.25, -12.89, -13.39]
```
