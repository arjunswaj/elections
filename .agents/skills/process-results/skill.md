# process-results

Run SQL queries against the PostgreSQL `assembly_elections_may2026` table, filtered per state, and export results as CSV files into `result/<STATE>/` directories.

## When to Use

- After the election data has been loaded into PostgreSQL (via `queries/Queries.sql`)
- When adding a new state's results (run queries for just that state)
- When regenerating all CSV results from scratch
- When SQL queries have been modified and CSVs need to be refreshed

## Prerequisites

- PostgreSQL is running and accessible (see `queries/Queries.sql` for connection details)
- The `assembly_elections_may2026` table exists and is populated
- The `election_gates` table exists and is populated (see Election Gates below)
- `psql` is available on PATH
- The database user has SELECT access on the table

## Database Connection

The connection details are in `queries/Queries.sql`:
- Host: `192.168.64.3`
- User: `postgres` (setup) / `arjunswaj` (queries)
- Database: `elections`

The connection string is exposed via the `PSQL_CONN` environment variable (default: `-h 192.168.64.3 -U arjunswaj -d elections`).

## Workflow

### Step 1: Verify database connectivity

```bash
psql -h 192.168.64.3 -U arjunswaj -d elections -c "SELECT COUNT(*) FROM assembly_elections_may2026;"
```

### Step 2: Configure states

Edit the `STATES` and `STATE_DISPLAY` arrays at the top of `.agents/skills/process-results/run-queries.sh`:

```bash
STATES=("ASSAM" "KERALA" "PUDUCHERRY" "TAMIL NADU" "WEST BENGAL")
STATE_DISPLAY=("Assam" "Kerala" "Puducherry" "Tamil Nadu" "West Bengal")
```

- `STATES`: Uppercase directory names under `result/`
- `STATE_DISPLAY`: Matching PostgreSQL `STATE` column values (as stored in the DB)

### Step 3: Create output directories

```bash
for state in "${STATES[@]}"; do mkdir -p "result/$state"; done
```

### Step 4: Run queries per state

```bash
bash .agents/skills/process-results/run-queries.sh
```

This script loops over all configured states and runs each query file with `WHERE STATE = '<display>'` injected, exporting results to numbered CSV files in `result/<STATE>/`.

### Step 5: Run party-specific queries

The script also handles query `09 Party specific.sql` by:
1. Getting the list of distinct parties for that state from the `12 All Parties.csv` output
2. Running the party-specific query with `RUNNER_UP_PARTY = '<party>'` for each party
3. Saving as `19 Party Specific - <Party>.csv`

### Step 6: Verify CSVs

Confirm each state directory has the expected ~30 CSV files:

```bash
ls result/<STATE>/*.csv | wc -l
```

### Step 7: Proceed to generate-report skill

Once CSVs are in place, use the `generate-report` skill to produce the markdown summaries.

## Query-to-CSV Mapping

Each `.sql` file in `queries/` may contain multiple SQL statements separated by `--` comment headers. The `run-queries.sh` script splits these and maps them to numbered output CSVs:

| Query File | Statement | Output CSV |
| --- | --- | --- |
| `01 Number Of Candidates.sql` | By party and state | `01 Number Of Candidates.csv` |
| | Votes by state | `01 Number Of Votes.csv` |
| | Candidates by state | `01 Number Of Candidates by State.csv` |
| `02 Maximum Votes for a Candidate.sql` | All candidates by votes | `02 Maximum Votes for a Candidate.csv` |
| | Max votes of winning candidates | `02 Max votes of winning candidates.csv` |
| | Least votes for a winning candidate | `03 Least votes for a winning candidate.csv` |
| | Max votes for a losing candidate | `04 Max votes for a losing candidate.csv` |
| | Max/Min margin winners | `05 Candidates winning by Max or Min margin.csv` |
| `03 Constituency with maximum votes.sql` | Max total votes | `06 Max Total Votes in Constituency.csv` |
| | Min total votes | *(same file, different sort)* |
| | Max candidates | `07 Max Candidates in a Constituency.csv` |
| | Least candidates | *(same file, different sort)* |
| `04 Vote Shares.sql` | Total vote share | `08 Total Vote Share.csv` |
| | Least vote share winning | `09 Least Vote share of Winning Candidate.csv` |
| | Max vote share losing | `10 Max Vote share of a losing candidate.csv` |
| | Lost deposits | `11 LOST Deposits.csv` |
| `05 Medals.sql` | All parties | `12 All Parties.csv` |
| | Gold | `12 Gold.csv` |
| | Silver | `13 Silver.csv` |
| `06 Strike Rates.sql` | Cost per vote | `14 Cost per vote.csv` |
| | Strike rate best | `14 Success Ratio.csv` |
| | Strike rate worst | `15 Strike Rate - Worst (At least 1 Win).csv` |
| `07 Multiple Participation.sql` | Multi-seat candidates | `16 Multiple Participation.csv` |
| | Multi-seat results | `17 Multiple Participation Results.csv` |
| `08 Close contest matrix.sql` | Close contest matrix | `18 Close Contest Matrix.csv` |
| `09 Party specific.sql` | Per-party close contests | `19 Party Specific - <Party>.csv` |
| `10 Crowding Pressure Seats.sql` | Crowding pressure | `22 Crowding Pressure Seats.csv` |
| `11 Runner Up Overperformance.sql` | Runner-up overperformance | `23 Runner Up Overperformance.csv` |
| `12 HHI Win Mix.sql` | HHI win mix | `24 HHI Win Mix.csv` |
| `13 Third Place Spoilers.sql` | Third-place spoilers | `25 Third Place Spoilers.csv` |

## Election Gates

The `election_gates` table controls which constituencies are included or excluded from all queries. This handles scenarios like repolls or deferred elections where vote data is corrupt (e.g., all votes = 0).

### Schema

```sql
CREATE TYPE election_gate_status AS ENUM ('EXCLUDE', 'INCLUDE');

CREATE TABLE election_gates (
  code VARCHAR(10) NOT NULL,
  state VARCHAR(100) NOT NULL,
  status election_gate_status NOT NULL DEFAULT 'EXCLUDE',
  UNIQUE (code, status)
);
```

- `code`: The constituency code (primary key for constituencies in the main table)
- `state`: The state name (matches `STATE` column in main table)
- `status`: `EXCLUDE` or `INCLUDE`

### How it works

All queries in `run-queries.sh` and the `.sql` files in `queries/` use a `LEFT JOIN election_gates eg ON eg.code = <alias>.code AND eg.status = 'EXCLUDE'` followed by `WHERE eg.code IS NULL` to exclude gated-out constituencies.

### Current exclusions

| code | state | constituency | reason |
| --- | --- | --- | --- |
| S25144 | WEST BENGAL | FALTA | Repoll — all votes = 0 |

### Adding new exclusions

```sql
INSERT INTO election_gates (code, state, status)
VALUES ('<code>', '<State>', 'EXCLUDE')
ON CONFLICT (code, status) DO NOTHING;
```

Then re-run the `process-results` and `generate-report` skills.

### Re-including a constituency

```sql
DELETE FROM election_gates WHERE code = '<code>' AND status = 'EXCLUDE';
```

Then re-run the skills.

## Known Gotchas

- **Election gates**: All queries exclude constituencies in `election_gates` with `status = 'EXCLUDE'`. The script verifies the table exists before running. If missing, run `queries/Queries.sql` to create it.
- **Multi-statement SQL files**: Queries `01` through `08` contain multiple SQL statements. The run-queries.sh script splits on blank lines or `--` comment headers and maps each to its numbered output CSV.
- **STATE column values**: PostgreSQL stores state names in Title Case (e.g., `Assam`, `Tamil Nadu`). The `STATE_DISPLAY` array must match exactly.
- **Party-specific query (09)**: This query has `RUNNER_UP_PARTY` hardcoded. The script replaces it with the correct party name for each iteration.
- **HHI Win Mix (12)**: Uses `NULLIF(s.total_pct, 0)` to avoid division-by-zero. Do not remove this.
- **LIMIT clauses**: Queries 10, 11, 13 have `LIMIT 15`. These may need adjusting for larger states.
- **CSV quoting**: `psql \copy` or `COPY ... TO ... CSV HEADER` is used. Values with commas must be properly quoted.
- **Numbering gaps**: Output CSVs skip numbers 19-21 (party-specific uses 19, advanced insights start at 22). This is intentional.

## Key Files

| File | Purpose |
| --- | --- |
| `queries/Queries.sql` | Table creation, data import, and election_gates DDL |
| `queries/01 Number Of Candidates.sql` | Candidate/vote count queries |
| `queries/02 Maximum Votes for a Candidate.sql` | Vote extremes and margin queries |
| `queries/03 Constituency with maximum votes.sql` | Constituency-level stats |
| `queries/04 Vote Shares.sql` | Vote share and deposit queries |
| `queries/05 Medals.sql` | Party lists and medal queries |
| `queries/06 Strike Rates.sql` | Cost and success ratio queries |
| `queries/07 Multiple Participation.sql` | Multi-seat candidate queries |
| `queries/08 Close contest matrix.sql` | Close contest matrix query |
| `queries/09 Party specific.sql` | Party-specific close contest query |
| `queries/10 Crowding Pressure Seats.sql` | Crowding pressure query |
| `queries/11 Runner Up Overperformance.sql` | Runner-up overperformance query |
| `queries/12 HHI Win Mix.sql` | HHI competition bands query |
| `queries/13 Third Place Spoilers.sql` | Third-place spoiler query |
| `.agents/skills/process-results/run-queries.sh` | Script to run all queries per state |
