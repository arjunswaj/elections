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
         - [Success Ratio - Worst](#success-ratio---worst)
      + [Multiple Seat Participation](#multiple-seat-participation)
         - [Candidates participating in multiple seats (matches names)](#candidates-participating-in-multiple-seats-matches-names)
      + [Close Contest Matrix](#close-contest-matrix)
         - [Party Specific Close Contest Matrix](#party-specific-close-contest-matrix)
            * [Bharatiya Janata Party](#bharatiya-janata-party)
            * [Indian National Congress](#indian-national-congress)
        + [Advanced Join Insights](#advanced-join-insights)
            - [Crowding pressure seats](#crowding-pressure-seats)
            - [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
            - [HHI win mix by party](#hhi-win-mix-by-party)
            - [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of New Delhi Assembly Elections February 2025

The 2025 Delhi Legislative Assembly elections were held in Delhi on 5 February 2025 to elect all 70 members of the Delhi Legislative Assembly. The counting of votes and declaration of result took place on 8 February 2025. ([wiki](https://en.wikipedia.org/wiki/2025_Delhi_Legislative_Assembly_election)).

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/delhi-2025/result/NewDelhi).

## Analysis
A total of 699 candidates contested in the elections and around 94 Lakhs (`9488376`) votes were casted during this period.

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
    x-axis ["Independent", "Aam Aadmi Party", "Indian National Congress", "Bharatiya Janata Party", "Bahujan Samaj Party", "Right to Recall Party", "Peoples Party of India (Democratic)", "Nationalist Congress Party", "Aazad Samaj Party (Kanshi Ram)", "Yuva Bharat Rashtraseva Party"]
    y-axis "Number of Seats" 0 --> 150
    bar [138, 70, 70, 68, 68, 20, 18, 17, 14, 7]
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
    x-axis ["SANDEEP SEHRAWAT (BJP, MATIALA)", "PANKAJ KUMAR SINGH (BJP, VIKASPURI)", "MAHINDER YADAV (AAP, VIKASPURI)", "SANJEEV JHA (AAP, BURARI)", "RAVINDER INDRAJ SINGH (BJP, BAWANA)"]
    y-axis "Number of Votes" 100000 --> 150000
    bar [146295, 135564, 122688, 121181, 119515]
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
    x-axis ["TARVINDER SINGH MARWAH (BJP, JANGPURA)", "UMANG BAJAJ (BJP, RAJINDER NAGAR)", "CHANDAN KUMAR CHOUDHARY (BJP, SANGAM VIHAR)", "SURYA PRAKASH KHATRI (BJP, TIMARPUR)", "RAVI KANT (BJP, TRILOKPURI)"]
    y-axis "Number of Votes" 35000 --> 60000
    bar [38859, 46671, 54049, 55941, 58217]
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
    x-axis ["MAHINDER YADAV (AAP, VIKASPURI)", "SUMESH SHOKEEN (AAP, MATIALA)", "SHAILENDRA KUMAR (JD(U), BURARI)", "JAI BHAGWAN UPKAR (AAP, BAWANA)", "NARAYAN DUTT SHARMA (BJP, BADARPUR)"]
    y-axis "Number of Votes" 80000 --> 130000
    bar [122688, 117572, 100580, 88040, 87103]
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
    x-axis ["AALEY MOHAMMED IQBAL (AAP, MATIA MAHAL)", "CHAUDHARY ZUBAIR AHMAD (AAP, SEELAM PUR)", "VIJENDER GUPTA (BJP, ROHINI)", "PREM CHAUHAN (AAP, DEOLI)", "RAVINDER INDRAJ SINGH (BJP, BAWANA)"]
    y-axis "Vote Difference" 30000 --> 45000
    bar [42724, 42477, 37816, 36680, 31475]
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
    x-axis ["CHANDAN KUMAR CHOUDHARY (BJP, SANGAM VIHAR)", "RAVI KANT (BJP, TRILOKPURI)", "TARVINDER SINGH MARWAH (BJP, JANGPURA)", "SURYA PRAKASH KHATRI (BJP, TIMARPUR)", "UMANG BAJAJ (BJP, RAJINDER NAGAR)"]
    y-axis "Vote Difference" 0 --> 1500
    bar [344, 392, 675, 1168, 1231]
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
    x-axis ["MATIALA (NEW DELHI)", "VIKASPURI (NEW DELHI)", "BURARI (NEW DELHI)", "BAWANA (NEW DELHI)", "OKHLA (NEW DELHI)"]
    y-axis "Total Votes" 200000 --> 300000
    bar [278894, 273648, 254737, 229856, 209522]
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
    x-axis ["DELHI CANTT (NEW DELHI)", "NEW DELHI (NEW DELHI)", "CHANDNI CHOWK (NEW DELHI)", "R. K. PURAM (NEW DELHI)", "MATIA MAHAL (NEW DELHI)"]
    y-axis "Total Votes" 40000 --> 90000
    bar [47458, 61636, 71173, 76503, 84475]
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
    x-axis ["NEW DELHI (NEW DELHI)", "JANAKPURI (NEW DELHI)", "LAXMI NAGAR (NEW DELHI)", "ROHTAS NAGAR (NEW DELHI)", "KARAWAL NAGAR (NEW DELHI)"]
    y-axis "Number of Candidates" 0 --> 30
    bar [24, 17, 16, 16, 16]
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
    x-axis ["PATEL NAGAR (NEW DELHI)", "KASTURBA NAGAR (NEW DELHI)", "MANGOL PURI (NEW DELHI)", "GREATER KAILASH (NEW DELHI)", "KAROL BAGH (NEW DELHI)"]
    y-axis "Number of Candidates" 5 --> 10
    bar [6, 6, 7, 7, 7]
```

#### Total Vote Share of Parties
```mermaid
pie
    title Total Vote Share of Parties
    "Bharatiya Janata Party" : 45.5622
    "Aam Aadmi Party" : 43.5680
    "Indian National Congress" : 6.3438
    "Janata Dal (United)" : 1.0600
    "All India Majlis-E-Ittehadul Muslimeen" : 0.7697
    "Bahujan Samaj Party" : 0.5804
    "None of the Above" : 0.5664
    "Lok Janshakti Party(Ram Vilas)" : 0.5292
    "Independent" : 0.4620
    "Aazad Samaj Party (Kanshi Ram)" : 0.0920
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
    x-axis ["AALEY MOHAMMED IQBAL (AAP, MATIA MAHAL)", "VIJENDER GUPTA (BJP, ROHINI)", "REKHA GUPTA (BJP, SHALIMAR BAGH)", "CHAUDHARY ZUBAIR AHMAD (AAP, SEELAM PUR)", "IMRAN HUSSAIN (AAP, BALLIMARAN)"]
    y-axis "Vote Share" 50 --> 75
    bar [68.8014, 65.0125, 59.9487, 59.2094, 58.0034]
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
    x-axis ["AAHIR DEEPAK CHAUDHARYY (BJP, BADLI)", "GAJENDER SINGH YADAV (BJP, MEHRAULI)", "MOHAN SINGH BISHT (BJP, MUSTAFABAD)", "AMANATULLAH KHAN (AAP, OKHLA)", "CHANDAN KUMAR CHOUDHARY (BJP, SANGAM VIHAR)"]
    y-axis "Vote Share" 40 --> 45
    bar [40.5605, 41.6680, 42.3616, 42.4504, 42.9936]
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
    x-axis ["DURGESH PATHAK (AAP, RAJINDER NAGAR)", "ANJANA PARCHA (AAP, TRILOKPURI)", "RAAJ KUMAR ANAND (BJP, PATEL NAGAR)", "JITENDER SINGH SHUNTY (AAP, SHAHDARA)", "RAMESH BIDHURI (BJP, KALKAJI)"]
    y-axis "Vote Share" 45 --> 47
    bar [46.74, 45.79, 45.55, 45.54, 45.50]
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
    x-axis ["Independent", "Bahujan Samaj Party", "Indian National Congress", "Right to Recall Party", "Peoples Party of India (Democratic)", "Nationalist Congress Party", "Aazad Samaj Party (Kanshi Ram)"]
    y-axis "Number of Seats" 0 --> 150
    bar [138, 68, 67, 20, 18, 17, 14]
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
    x-axis ["Bharatiya Janata Party", "Aam Aadmi Party"]
    y-axis "Number of Seats" 0 --> 50
    bar [48, 22]
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
    x-axis ["Aam Aadmi Party", "Bharatiya Janata Party", "Indian National Congress", "Lok Janshakti Party(Ram Vilas)", "Janata Dal (United)"]
    y-axis "Number of Seats" 0 --> 50
    bar [47, 20, 1, 1, 1]
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
    x-axis ["Janata Dal (United)", "Bharatiya Janata Party", "Aam Aadmi Party", "Lok Janshakti Party(Ram Vilas)", "All India Majlis-E-Ittehadul Muslimeen"]
    y-axis "Cost per Vote" 0 --> 120
    bar [39.7693, 62.9177, 67.7327, 79.6670, 109.5410]
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
    x-axis ["Bharatrashtra Democratic Party", "Navarang Congress Party", "All India National Raksha Sena", "Samarth Bharatvarsh Party", "Rashtrawadi Janlok Party (Satya)"]
    y-axis "Cost per Vote" 70000 --> 120000
    bar [1000000.0000, 222222.2222, 200000.0000, 181818.1818, 163265.3061]
```

#### Success Ratio - Best

|Party                  |Seats Participated|Seats Won|Success Ratio|
|-----------------------|------------------|---------|-------------|
|Bharatiya Janata Party |68                |48       |70.5882      |
|Aam Aadmi Party        |70                |22       |31.4286      |

#### Success Ratio - Worst

|Party                    |Seats Participated|Seats Won|Success Ratio|
|-------------------------|------------------|---------|-------------|
|Indian National Congress |70                |1        |1.4286       |

### Multiple Seat Participation

#### Results of Candidates participating in multiple seats

|Candidate            |Constituency    |State     |Party                        |Result|
|---------------------|----------------|----------|-----------------------------|------|
|ASHOK KUMAR          |ROHTAS NAGAR    |NEW DELHI |Bahujan Samaj Party          |LOST  |
|ASHOK KUMAR          |MUSTAFABAD      |NEW DELHI |Bahujan Samaj Party          |LOST  |
|MUKESH KUMAR         |MANGOL PURI     |NEW DELHI |Bahujan Samaj Party          |LOST  |
|MUKESH KUMAR         |NANGLOI JAT     |NEW DELHI |Bahujan Samaj Party          |LOST  |
|MUKESH KUMAR         |KONDLI          |NEW DELHI |Bahujan Samaj Party          |LOST  |
|ASHOK KUMAR          |AMBEDKAR NAGAR  |NEW DELHI |Independent                  |LOST  |
|ASHOK KUMAR          |HARI NAGAR      |NEW DELHI |Independent                  |LOST  |
|DEEPAK KUMAR         |SULTANPUR MAJRA |NEW DELHI |Independent                  |LOST  |
|DEEPAK KUMAR         |KAROL BAGH      |NEW DELHI |Independent                  |LOST  |
|RAVI                 |KALKAJI         |NEW DELHI |Independent                  |LOST  |
|RAVI                 |MADIPUR         |NEW DELHI |Independent                  |LOST  |
|CHARAN SINGH MALIYAN |GOKALPUR        |NEW DELHI |Right to Recall Party        |LOST  |
|CHARAN SINGH MALIYAN |SEEMAPURI       |NEW DELHI |Right to Recall Party        |LOST  |

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

| PARTY                           | < 500 | < 2500 | < 5000 | < 10000 | < 15000 | < 25000 | < 50000 |
|---------------------------------|-------|--------|--------|---------|---------|---------|---------|
| Aam Aadmi Party                 | 2     | 7      | 9      | 16      | 27      | 35      | 47      |
| Bharatiya Janata Party          | 0     | 1      | 4      | 8       | 11      | 16      | 20      |
| Indian National Congress        | 0     | 0      | 0      | 0       | 1       | 1       | 1       |
| Janata Dal (United)             | 0     | 0      | 0      | 0       | 0       | 1       | 1       |
| Lok Janshakti Party (Ram Vilas) | 0     | 0      | 0      | 0       | 0       | 0       | 1       |

#### Party Specific Close Contest Matrix

##### Bharatiya Janata Party

| Constituency     | State     | Runner up Votes | Winning Party      | Winning Votes | Vote Difference |
|------------------|-----------|-----------------|--------------------|---------------|-----------------|
| DELHI CANTT      | NEW DELHI | 20162           | Aam Aadmi Party    | 22191         | 2029            |
| KALKAJI          | NEW DELHI | 48633           | Aam Aadmi Party    | 52154         | 3521            |
| PATEL NAGAR      | NEW DELHI | 53463           | Aam Aadmi Party    | 57512         | 4049            |
| AMBEDKAR NAGAR   | NEW DELHI | 42055           | Aam Aadmi Party    | 46285         | 4230            |
| KONDLI           | NEW DELHI | 55499           | Aam Aadmi Party    | 61792         | 6293            |
| SADAR BAZAR      | NEW DELHI | 49870           | Aam Aadmi Party    | 56177         | 6307            |
| KAROL BAGH       | NEW DELHI | 44867           | Aam Aadmi Party    | 52297         | 7430            |
| GOKALPUR         | NEW DELHI | 72297           | Aam Aadmi Party    | 80504         | 8207            |
| SEEMAPURI        | NEW DELHI | 55985           | Aam Aadmi Party    | 66353         | 10368           |
| TILAK NAGAR      | NEW DELHI | 40478           | Aam Aadmi Party    | 52134         | 11656           |
| TUGHLAKABAD      | NEW DELHI | 47444           | Aam Aadmi Party    | 62155         | 14711           |
| CHANDNI CHOWK    | NEW DELHI | 22421           | Aam Aadmi Party    | 38993         | 16572           |
| SULTANPUR MAJRA  | NEW DELHI | 41641           | Aam Aadmi Party    | 58767         | 17126           |
| BABARPUR         | NEW DELHI | 57198           | Aam Aadmi Party    | 76192         | 18994           |
| KIRARI           | NEW DELHI | 83909           | Aam Aadmi Party    | 105780        | 21871           |
| OKHLA            | NEW DELHI | 65304           | Aam Aadmi Party    | 88943         | 23639           |
| BADARPUR         | NEW DELHI | 87103           | Aam Aadmi Party    | 112991        | 25888           |
| BALLIMARAN       | NEW DELHI | 27181           | Aam Aadmi Party    | 57004         | 29823           |
| SEELAM PUR       | NEW DELHI | 36532           | Aam Aadmi Party    | 79009         | 42477           |
| MATIA MAHAL      | NEW DELHI | 15396           | Aam Aadmi Party    | 58120         | 42724           |

##### AAP Close Fight

| Constituency    | State     | Runner up Votes | Winning Party              | Winning Votes | Vote Difference |
|-----------------|-----------|-----------------|----------------------------|---------------|-----------------|
| SANGAM VIHAR    | NEW DELHI | 53705           | Bharatiya Janata Party     | 54049         | 344             |
| TRILOKPURI      | NEW DELHI | 57825           | Bharatiya Janata Party     | 58217         | 392             |
| JANGPURA        | NEW DELHI | 38184           | Bharatiya Janata Party     | 38859         | 675             |
| TIMARPUR        | NEW DELHI | 54773           | Bharatiya Janata Party     | 55941         | 1168            |
| RAJINDER NAGAR  | NEW DELHI | 45440           | Bharatiya Janata Party     | 46671         | 1231            |
| MEHRAULI        | NEW DELHI | 46567           | Bharatiya Janata Party     | 48349         | 1782            |
| MALVIYA NAGAR   | NEW DELHI | 37433           | Bharatiya Janata Party     | 39564         | 2131            |
| GREATER KAILASH | NEW DELHI | 46406           | Bharatiya Janata Party     | 49594         | 3188            |
| NEW DELHI       | NEW DELHI | 25999           | Bharatiya Janata Party     | 30088         | 4089            |
| SHAHDARA        | NEW DELHI | 57610           | Bharatiya Janata Party     | 62788         | 5178            |
| CHHATARPUR      | NEW DELHI | 74230           | Bharatiya Janata Party     | 80469         | 6239            |
| MANGOL PURI     | NEW DELHI | 55752           | Bharatiya Janata Party     | 62007         | 6255            |
| HARI NAGAR      | NEW DELHI | 43547           | Bharatiya Janata Party     | 50179         | 6632            |
| DWARKA          | NEW DELHI | 61308           | Bharatiya Janata Party     | 69137         | 7829            |
| NERELA          | NEW DELHI | 78619           | Bharatiya Janata Party     | 87215         | 8596            |
| PALAM           | NEW DELHI | 73094           | Bharatiya Janata Party     | 82046         | 8952            |
| MUNDKA          | NEW DELHI | 79289           | Bharatiya Janata Party     | 89839         | 10550           |
| MADIPUR         | NEW DELHI | 41120           | Bharatiya Janata Party     | 52019         | 10899           |
| BIJWASAN        | NEW DELHI | 53675           | Bharatiya Janata Party     | 64951         | 11276           |
| WAZIRPUR        | NEW DELHI | 43296           | Bharatiya Janata Party     | 54721         | 11425           |

##### Indian National Congress

|Constituency   |State     |Runner up Votes|Winning Party             |Winning Votes|Vote Difference|
|---------------|----------|---------------|--------------------------|-------------|---------------|
|KASTURBA NAGAR |NEW DELHI |27019          |Bharatiya Janata Party    |38067        |11048          |

### Advanced Join Insights

#### Crowding pressure seats

Crowded ballots with thin margins are visualized below using "others" vote share as a proxy for fragmentation.

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
    x-axis ["MEHRAULI", "SANGAM VIHAR", "DELHI CANTT", "SADAR BAZAR", "JANGPURA", "MALVIYA NAGAR", "AMBEDKAR NAGAR", "HARI NAGAR"]
    y-axis "Others Vote %" 0 --> 20
    bar [18.21, 14.29, 10.76, 10.42, 9.91, 9.46, 9.10, 9.05]
```

#### Runner-up overperformance vs party baseline

These runner-up candidates beat their party-wide average vote share even in defeat.

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
    x-axis ["KASTURBA NAGAR", "RAJINDER NAGAR", "TRILOKPURI", "SHAHDARA", "CHHATARPUR", "MANGOL PURI", "TIMARPUR", "NERELA"]
    y-axis "Overperformance %" 0 --> 30
    bar [25.29, 2.99, 2.04, 1.79, 1.43, 1.41, 1.32, 1.24]
```

#### HHI win mix by party

Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types.

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
    x-axis ["Fragmented", "Competitive", "Dominant"]
    y-axis "Seats Won" 0 --> 30
    bar "Aam Aadmi Party" [1, 16, 5]
    bar "Bharatiya Janata Party" [3, 23, 22]
```

#### Third-place spoilers in tight races

Third-place candidacies that materially exceeded their party’s norm highlight potential spoiler roles.

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
    x-axis ["MEHRAULI", "SANGAM VIHAR", "DELHI CANTT", "JANGPURA", "SADAR BAZAR", "MALVIYA NAGAR", "NEW DELHI", "AMBEDKAR NAGAR"]
    y-axis "Overperformance %" 0 --> 9
    bar [8.16, 5.93, 2.27, 1.91, 1.80, 1.27, 0.72, 0.69]
```