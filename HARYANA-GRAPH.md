# Table of contents

- [Analysis of Haryana Assembly Elections October 2024](#analysis-of-haryana-assembly-elections-october-2024)
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
         - [Success Ratio - Best](#success-ratio---best-1)
      + [Multiple Seat Participation](#multiple-seat-participation)
         - [Candidates participating in multiple seats (matches names)](#candidates-participating-in-multiple-seats-matches-names)
      + [Close Contest Matrix](#close-contest-matrix)
         - [Party Specific Close Contest Matrix](#party-specific-close-contest-matrix)
            * [Bharatiya Janata Party](#bharatiya-janata-party)
            * [Indian National Congress](#indian-national-congress)

# Analysis of Haryana Assembly Elections October 2024

The 2024 Haryana Legislative Assembly elections were held in Haryana on 5 October 2024 to elect all 90 members of the Haryana Legislative Assembly ([wiki](https://en.wikipedia.org/wiki/2024_Haryana_Legislative_Assembly_election)).

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/haryana-jk-2024/result/Haryana).

## Analysis
A total of 1031 candidates contested in the elections and around 1.38 Crores (`13891280`) votes were casted during this period.

### Seats contested by Parties
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Seats Contested by Parties"
    x-axis ["Independent", "Indian National Congress", "Bharatiya Janata Party", "Aam Aadmi Party", "Jannayak Janta Party", "Indian National Lok Dal", "Bahujan Samaj Party", "Aazad Samaj Party (Kanshi Ram)", "Peoples Party of India (Democratic)", "Bhartiya Shakti Chetna Party"]
    y-axis "Number of Seats" 0 --> 500
    bar [464, 89, 89, 88, 66, 51, 35, 12, 12, 11]
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
---
xychart-beta
    title "Maximum Votes for a Candidate"
    x-axis ["RAO NARBIR SINGH (BJP, BADSHAHPUR)", "MAMMAN KHAN (INC, FEROZEPUR JHIRKA)", "MUKESH SHARMA (BJP, GURGAON)", "GAURAV GAUTAM (BJP, PALWAL)", "BHUPINDER SINGH HOODA (INC, GARHI SAMPLA)"]
    y-axis "Number of Votes" 40000 --> 150000
    bar [145503, 130497, 122615, 109118, 108539]
```

#### Least votes for a winning candidate
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Least Votes for a Winning Candidate"
    x-axis ["SATPAL JAMBA (BJP, PUNDRI)", "ARJUN CHAUTALA (INLD, RANIA)", "VIKAS SAHARAN (INC, KALAYAT)", "DEVENDER CHATAR BHUJ ATTRI (BJP, UCHANA KALAN)", "SAVITRI JINDAL (Independent, HISAR)"]
    y-axis "Number of Votes" 40000 --> 50000
    bar [42805, 43914, 48142, 48968, 49231]
```

#### Max votes for a losing candidate
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Max Votes for a Losing Candidate"
    x-axis ["VARDHAN YADAV (INC, BADSHAHPUR)", "DURA RAM (BJP, FATEHABAD)", "VARINDER SINGH RATHORE (INC, GHARAUNDA)", "JAI PARKASH DALAL (BJP, LOHARU)", "DEVENDER SINGH BABLI (BJP, TOHANA)"]
    y-axis "Number of Votes" 70000 --> 90000
    bar [84798, 83920, 82705, 80544, 77686]
```

#### Candidates winning by Max margin (Unilateral winner)
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Candidates Winning by Max Margin"
    x-axis ["MAMMAN KHAN (INC, FEROZEPUR JHIRKA)", "BHUPINDER SINGH HOODA (INC, GARHI SAMPLA)", "MUKESH SHARMA (BJP, GURGAON)", "RAO NARBIR SINGH (BJP, BADSHAHPUR)", "MAHIPAL DHANDA (BJP, PANIPAT RURAL)"]
    y-axis "Vote Difference" 30000 --> 100000
    bar [98441, 71465, 68045, 60705, 50212]
```

#### Candidates winning by Least margin (Fierce battle)
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Candidates Winning by Least Margin"
    x-axis ["DEVENDER CHATAR BHUJ ATTRI (BJP, UCHANA KALAN)", "ADITYA DEVILAL (INLD, DABWALI)", "RAJBIR FARTIA (INC, LOHARU)", "CHANDER PARKASH S/O ARJUN LAL (INC, ADAMPUR)", "BHARAT BHUSHAN BATRA (INC, ROHTAK)"]
    y-axis "Vote Difference" 0 --> 1500
    bar [32, 610, 792, 1268, 1341]
```

#### Max Total Votes in a Constituency
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Max Total Votes in a Constituency"
    x-axis ["BADSHAHPUR (HARYANA)", "GURGAON (HARYANA)", "TIGAON (HARYANA)", "SOHNA (HARYANA)", "PANIPAT RURAL (HARYANA)"]
    y-axis "Total Votes" 200000 --> 300000
    bar [282285, 230104, 203714, 203562, 201139]
```

#### Min Total Votes Constituency
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Min Total Votes in a Constituency"
    x-axis ["NARNAUL (HARYANA)", "HISAR (HARYANA)", "KHARKHAUDA (HARYANA)", "NANGAL CHAUDHRY (HARYANA)", "BERI (HARYANA)"]
    y-axis "Total Votes" 100000 --> 120000
    bar [106576, 112494, 113716, 118473, 118966]
```

#### Max candidates in a Constituency
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Max Candidates in a Constituency"
    x-axis ["HISAR (HARYANA)", "UCHANA KALAN (HARYANA)", "MEHAM (HARYANA)", "PUNDRI (HARYANA)", "FATEHABAD (HARYANA)"]
    y-axis "Number of Candidates" 15 --> 25
    bar [22, 21, 20, 19, 19]
```

#### Least candidates in a Constituency
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Least Candidates in a Constituency"
    x-axis ["KALANWALI (HARYANA)", "NANGAL CHAUDHRY (HARYANA)", "INDRI (HARYANA)", "NUH (HARYANA)", "KALKA (HARYANA)"]
    y-axis "Number of Candidates" 5 --> 10
    bar [6, 6, 7, 7, 8]
```

#### Total Vote Share of Parties
```mermaid
pie
    title Total Vote Share of Parties
    "Bharatiya Janata Party" : 39.9445
    "Indian National Congress" : 39.0936
    "Independent" : 10.4298
    "Indian National Lok Dal" : 4.1407
    "Bahujan Samaj Party" : 1.8189
    "Aam Aadmi Party" : 1.7886
```

#### Maximum Vote share of Winning Candidate
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Maximum Vote Share of Winning Candidate"
    x-axis ["BHUPINDER SINGH HOODA (INC, GARHI SAMPLA)", "MAMMAN KHAN (INC, FEROZEPUR JHIRKA)", "VIPUL GOEL (BJP, FARIDABAD)", "BIMLA CHAUDHARY (BJP, PATAUDI)", "JAGMOHAN ANAND (BJP, KARNAL)"]
    y-axis "Vote Share" 50 --> 80
    bar [72.7239, 72.0317, 65.4504, 62.3961, 59.6576]
```

#### Least Vote share for a winning candidate
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Least Vote Share for a Winning Candidate"
    x-axis ["DEVENDER CHATAR BHUJ ATTRI (BJP, UCHANA KALAN)", "VIKAS SAHARAN (INC, KALAYAT)", "TEJPAL TANWAR (BJP, SOHNA)", "ARJUN CHAUTALA (INLD, RANIA)", "SATPAL JAMBA (BJP, PUNDRI)"]
    y-axis "Vote Share" 25 --> 35
    bar [29.4977, 30.0113, 30.0857, 30.4109, 31.4803]
```

#### Max Vote share of a losing candidate
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Max Vote Share of a Losing Candidate"
    x-axis ["JAI PARKASH DALAL (BJP, LOHARU)", "MANISH KUMAR GROVER (BJP, ROHTAK)", "VARINDER SINGH RATHORE (INC, GHARAUNDA)", "BHAVYA BISHNOI (BJP, ADAMPUR)", "UDAI BHAN (INC, HODAL)"]
    y-axis "Vote Share" 45 --> 50
    bar [48.49, 48.14, 47.33, 47.24, 46.95]
```

#### Seats in which Parties lost deposits (less than 1/6 vote share)
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Seats in which Parties Lost Deposits"
    x-axis ["Independent", "Aam Aadmi Party", "Jannayak Janta Party", "Indian National Lok Dal", "Bahujan Samaj Party"]
    y-axis "Number of Seats" 30 --> 450
    bar [446, 87, 65, 42, 31]
```

#### Gold (Seats that Parties won)
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Gold (Seats that Parties Won)"
    x-axis ["Bharatiya Janata Party", "Indian National Congress", "Independent", "Indian National Lok Dal"]
    y-axis "Number of Seats" 0 --> 50
    bar [48, 37, 3, 2]
```

#### Silver (Seats that Parties came in second)
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Silver (Seats that Parties Came in Second)"
    x-axis ["Indian National Congress", "Bharatiya Janata Party", "Independent", "Indian National Lok Dal", "Bahujan Samaj Party", "Communist Party of India (Marxist)", "Haryana Jan Sevak Party", "Haryana Lokhit Party"]
    y-axis "Number of Seats" 0 --> 50
    bar [45, 32, 7, 2, 1, 1, 1, 1]
```

#### Cost per vote - Best Value per vote
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Cost per Vote - Best Value"
    x-axis ["Bharatiya Janata Party", "Indian National Congress", "Communist Party of India (Marxist)", "Haryana Lokhit Party", "Haryana Jan Sevak Party"]
    y-axis "Cost per Vote" 50 --> 350
    bar [64.1580, 65.5544, 116.3704, 220.7140, 305.0873]
```

#### Cost per vote - Worst Value per vote
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Cost per Vote - Worst Value"
    x-axis ["Rashtravadi Bharat Party", "Bharat Jan Jagran Dal", "Bhartiya Janraj Party", "Bhartiya Sarvodaya Party", "Nationalist Congress Party"]
    y-axis "Cost per Vote" 70000 --> 120000
    bar [117647.0588, 102564.1026, 97560.9756, 83333.3333, 71428.5714]
```

#### Success Ratio - Best
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Success Ratio - Best"
    x-axis ["Bharatiya Janata Party", "Indian National Congress"]
    y-axis "Success Ratio" 40 --> 60
    bar [53.9326, 41.5730]
```

#### Success Ratio - Worst
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Success Ratio - Worst"
    x-axis ["Independent", "Indian National Lok Dal"]
    y-axis "Success Ratio" 0 --> 10
    bar [3.4483, 3.9216]
```

#### Candidates participating in multiple seats (matches names)
```mermaid
---
config:
    xyChart:
        width: 1200
        height: 600
        chartOrientation: horizontal
---
xychart-beta
    title "Candidates Participating in Multiple Seats"
    x-axis ["ANIL KUMAR", "RAJESH KUMAR", "SUNIL KUMAR"]
    y-axis "Number of Constituencies" 0 --> 5
    bar [4, 4, 4]
```

### Close Contest Matrix

This Matrix provides the number of seats in which parties lost by the number of votes provided in the columns.
|PARTY                                             |< 500|< 2500|< 5000|< 10000|< 15000|< 25000|< 50000|
|--------------------------------------------------|-----|------|------|-------|-------|-------|-------|
|Bahujan Samaj Party                               |0    |0     |1     |1      |1      |1      |1      |
|Bharatiya Janata Party                            |0    |6     |7     |13     |20     |26     |30     |
|Communist Party of India  (Marxist)               |0    |0     |0     |0      |0      |0      |1      |
|Haryana Jan Sevak Party                           |0    |0     |0     |0      |0      |1      |1      |
|Haryana Lokhit Party                              |0    |0     |0     |1      |1      |1      |1      |
|Independent                                       |0    |1     |1     |3      |3      |4      |6      |
|Indian National Congress                          |1    |4     |10    |13     |21     |33     |43     |
|Indian National Lok Dal                           |0    |0     |0     |0      |0      |1      |2      |

#### Party Specific Close Contest Matrix

##### Bharatiya Janata Party

|Constituency                                      |State   |Runner up Party Votes|Winning Party           |Winning Party Votes|Vote Difference|
|--------------------------------------------------|--------|---------------------|------------------------|-------------------|---------------|
|LOHARU                                            |HARYANA |80544               |Indian National Congress|81336              |792            |
|ADAMPUR                                           |HARYANA |64103               |Indian National Congress|65371              |1268           |
|ROHTAK                                            |HARYANA |58078               |Indian National Congress|59419              |1341           |
|SADHAURA                                          |HARYANA |55835               |Indian National Congress|57534              |1699           |
|PANCHKULA                                         |HARYANA |65400               |Indian National Congress|67397              |1997           |
|FATEHABAD                                         |HARYANA |83920               |Indian National Congress|86172              |2252           |
|THANESAR                                          |HARYANA |66833               |Indian National Congress|70076              |3243           |
|JULANA                                            |HARYANA |59065               |Indian National Congress|65080              |6015           |
|SHAHBAD                                           |HARYANA |54609               |Indian National Congress|61050              |6441           |
|PEHOWA                                            |HARYANA |57995               |Indian National Congress|64548              |6553           |


##### Indian National Congress

|Constituency                                      |State   |Runner up Party Votes|Winning Party           |Winning Party Votes|Vote Difference|
|--------------------------------------------------|--------|---------------------|------------------------|-------------------|---------------|
|UCHANA KALAN                                      |HARYANA |48936               |Bharatiya Janata Party  |48968              |32             |
|DABWALI                                           |HARYANA |55464               |Indian National Lok Dal |56074              |610            |
|DADRI                                            |HARYANA |63611               |Bharatiya Janata Party  |65568              |1957           |
|ASSANDH                                          |HARYANA |52455               |Bharatiya Janata Party  |54761              |2306           |
|HODAL                                            |HARYANA |66270               |Bharatiya Janata Party  |68865              |2595           |
|MAHENDRAGARH                                     |HARYANA |60388               |Bharatiya Janata Party  |63036              |2648           |
|SAFIDON                                          |HARYANA |54946               |Bharatiya Janata Party  |58983              |4037           |
|RANIA                                            |HARYANA |39723               |Indian National Lok Dal |43914              |4191           |
|GHARAUNDA                                        |HARYANA |82705               |Bharatiya Janata Party  |87236              |4531           |
|RAI                                              |HARYANA |59941               |Bharatiya Janata Party  |64614              |4673           |
