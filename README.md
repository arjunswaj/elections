# Table of contents
- [Results](#results)
- [Building and Running](#building-and-running)
  * [Scraping and downloading data](#scraping-and-downloading-data)
    + [Tests](#tests)
  * [Data Analysis](#data-analysis)

## Results — Assembly Elections May 2026

| State | Tabular | Graphical |
| --- | --- | --- |
| Assam | [Assam.md](result/ASSAM/Assam.md) | [Assam-GRAPH.md](result/ASSAM/Assam-GRAPH.md) |
| Kerala | [Kerala.md](result/KERALA/Kerala.md) | [Kerala-GRAPH.md](result/KERALA/Kerala-GRAPH.md) |
| Puducherry | [Puducherry.md](result/PUDUCHERRY/Puducherry.md) | [Puducherry-GRAPH.md](result/PUDUCHERRY/Puducherry-GRAPH.md) |
| Tamil Nadu | [Tamil Nadu.md](result/TAMIL%20NADU/Tamil%20Nadu.md) | [Tamil Nadu-GRAPH.md](result/TAMIL%20NADU/Tamil%20Nadu-GRAPH.md) |
| West Bengal | [West Bengal.md](result/WEST%20BENGAL/West%20Bengal.md) | [West Bengal-GRAPH.md](result/WEST%20BENGAL/West%20Bengal-GRAPH.md) |

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
Create table executing [`Queries.sql`](queries/Queries.sql) and then run other SQL queries in the [queries](queries) directory to see the [detailed result](result).