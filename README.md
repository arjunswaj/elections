# Analysis of General Elections 2024

General elections were held in India from 19 April to 1 June 2024 in seven phases, to elect all 543 members of the Lok Sabha. Votes were counted and the result was declared on 4 June to form the 18th Lok Sabha ([wiki](https://en.wikipedia.org/wiki/2024_Indian_general_election)).

## Analysis
A total of 8360 candidates contested in the elections and around 64.5 Crores (`645363445`) votes were casted during this period.

### Seats contested by Parties
|Party                                        |Number of candidates|
|---------------------------------------------|--------------------|
|Independent                                  |3920                |
|Bahujan Samaj Party                          |488                 |
|Bharatiya Janata Party                       |441                 |
|Indian National Congress                     |328                 |
|Socialist Unity Centre Of India (COMMUNIST)  |150                 |
|Peoples Party of India (Democratic)          |79                  |
|Samajwadi Party                              |71                  |
|Communist Party of India  (Marxist)          |52                  |
|All India Trinamool Congress                 |48                  |
|Bharatheeya Jawan Kisan Party                |41                  |




## Building and Running
### Scraping and downloading data
```sh
cabal build
cabal run elections
```

#### Tests
```sh
cabal test
```

### Data Analysis
Create table executing [`Queries.sql`]() and then run other SQL queries in the [queries]() directory to see the result.