# Table of contents



## Results

- HARYANA
  - [Tabular](https://github.com/arjunswaj/elections/blob/haryana-jk-2024/HARYANA.md)
  - [Graphical](https://github.com/arjunswaj/elections/blob/haryana-jk-2024/HARYANA-GRAPH.md)
- JAMMU & KASHMIR
  - [Tabular](https://github.com/arjunswaj/elections/blob/haryana-jk-2024/J%26K.md)
  - [Graphical](https://github.com/arjunswaj/elections/blob/haryana-jk-2024/J%26K-GRAPH.md)

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