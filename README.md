# Table of contents



## Results

- [HARYANA](https://github.com/arjunswaj/elections/blob/haryana-jk-2024/HARYANA.md)
- [JAMMU & KASHMIR](https://github.com/arjunswaj/elections/blob/haryana-jk-2024/J%26K.md)

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