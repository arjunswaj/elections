# Table of contents
- [Results](#results)
- [Building and Running](#building-and-running)
  * [Scraping and downloading data](#scraping-and-downloading-data)
    + [Tests](#tests)
  * [Data Analysis](#data-analysis)

## Results

- [Tabular](https://github.com/arjunswaj/elections/blob/delhi-2025/NEWDELHI.md)
- [Graphical](https://github.com/arjunswaj/elections/blob/delhi-2025/NEWDELHI-GRAPH.md)

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
Create table executing [`Queries.sql`](https://github.com/arjunswaj/elections/blob/delhi-2025/queries/Queries.sql) and then run other SQL queries in the [queries](https://github.com/arjunswaj/elections/tree/delhi-2025/queries) directory to see the [detailed result](https://github.com/arjunswaj/elections/tree/delhi-2025/result).