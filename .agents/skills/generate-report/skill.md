# generate-report

Generate templatized markdown summary files (STATE.md and STATE-GRAPH.md) for each state from CSV query results.

## When to Use

- After running SQL queries and exporting CSV results to `result/<STATE>/` directories
- When adding a new state's election results
- When regenerating all markdown summaries after updating CSV data or the generation script
- When cleaning up legacy per-state markdown files from the repo root

## Prerequisites

- CSV files must exist in `result/<STATE>/` for each state (numbered 01–25, plus party-specific 19 files)
- `bc` must be available (for arithmetic in chart y-axis range calculations)
- Bash 4+ (for associative arrays and `${arr[-1]}` syntax)

## Workflow

### Step 1: Verify CSV data exists

For each state directory under `result/`, confirm the expected CSV files are present. The canonical set is:

| # | Filename pattern | Used in |
|---|---|---|
| 01 | Number Of Candidates by State.csv | Total candidates count |
| 01 | Number Of Candidates.csv | Seats contested table/chart |
| 01 | Number Of Votes.csv | Total votes count |
| 02 | Maximum Votes for a Candidate.csv | Max votes table/chart |
| 03 | Least votes for a winning candidate.csv | Least winning votes table/chart |
| 04 | Max votes for a losing candidate.csv | Max losing votes table/chart |
| 05 | Candidates winning by Max or Min margin.csv | Max/Least margin tables/charts |
| 06 | Max Total Votes in Constituency.csv | Constituency votes tables/charts |
| 07 | Max Candidates in a Constituency.csv | Candidate count tables/charts |
| 08 | Total Vote Share.csv | Vote share table/pie chart |
| 09 | Least Vote share of Winning Candidate.csv | Min/Max win vote share tables/charts |
| 10 | Max Vote share of a losing candidate.csv | Max losing vote share table/chart |
| 11 | LOST Deposits.csv | Lost deposits table/chart |
| 12 | All Parties.csv | Registered party count |
| 12 | Gold.csv | Gold (seats won) table/chart |
| 13 | Silver.csv | Silver (runner-up) table/chart |
| 14 | Cost per vote.csv | Cost per vote tables/charts |
| 14 | Success Ratio.csv | Success ratio table (filtered) |
| 15 | Strike Rate - Worst (At least 1 Win).csv | Worst strike rate table |
| 16 | Multiple Participation.csv | Multi-seat participation table |
| 17 | Multiple Participation Results.csv | Multi-seat results table |
| 18 | Close Contest Matrix.csv | Close contest matrix table |
| 19 | Party Specific - \<Party\>.csv | Per-party close contest tables (dynamic) |
| 22 | Crowding Pressure Seats.csv | Crowding pressure table/chart |
| 23 | Runner Up Overperformance.csv | Runner-up overperformance table/chart |
| 24 | HHI Win Mix.csv | HHI win mix table/stacked bar chart |
| 25 | Third Place Spoilers.csv | Third-place spoilers table/chart |

If any CSV is missing for a state, the generate script will fail. Check with:

```bash
ls result/<STATE>/*.csv | wc -l
```

### Step 2: Configure state metadata in generate.sh

Edit `result/generate.sh` and update the configuration arrays at the top:

```bash
STATES=("ASSAM" "KERALA" "PUDUCHERRY" "TAMIL NADU" "WEST BENGAL")
STATE_DISPLAY=("Assam" "Kerala" "Puducherry" "Tamil Nadu" "West Bengal")
STATE_MONTH=("May-2026" "May-2026" "May-2026" "May-2026" "May-2026")
STATE_MONTH_DISPLAY=("May 2026" "May 2026" "May 2026" "May 2026" "May 2026")
STATE_YEAR=("2026" "2026" "2026" "2026" "2026")
```

- `STATES`: Directory names under `result/` (uppercase, spaces for multi-word)
- `STATE_DISPLAY`: Human-readable names (Title Case)
- `STATE_MONTH`: Anchor-safe month format for TOC links (hyphens, no spaces)
- `STATE_MONTH_DISPLAY`: Human-readable month for headings
- `STATE_YEAR`: Election year

All arrays must be the same length and in the same order.

### Step 3: Run the generation script

```bash
bash result/generate.sh
```

This produces two files per state:
- `result/<STATE>/<Display>.md` — Tabular summary (markdown tables)
- `result/<STATE>/<Display>-GRAPH.md` — Graphical summary (mermaid charts + tables for sections without charts)

### Step 4: Verify generated markdown

Spot-check the generated files for:

1. **TOC anchors** — Multi-word state names must use hyphens (e.g., `#analysis-of-tamil-nadu-assembly-elections-may-2026`, NOT `#analysis-of-tamil nadu-...`). The `display_anchor` variable handles this.

2. **Party name shortening** — In GRAPH files, verify long party names are abbreviated (e.g., `BJP`, `INC`, `AIADMK`, `DMK`, `TVK`, `AITC`, `CPI(M)`). The `shorten_party` function handles this; ordering matters (longer matches before shorter, e.g., `AIADMK` rule before `DMK` rule).

3. **Success Ratio filter** — The `csv_to_md_success` function filters out rows where `seats_won` (column 3) is empty or zero. Verify no empty rows appear.

4. **Chart y-axis ranges** — Calculated dynamically from data values (e.g., `value * 1.2 / 1` for max, `value * 0.9 / 1` for min).

5. **Column header prettification** — The `prettify_col` function converts `snake_case` CSV headers to Title Case with special overrides (e.g., `HHI`, `Runner Up %`, `Seats < 1/6 Vote Share`).

### Step 5: Clean up legacy files

If old per-state markdown files exist in the repo root (e.g., `BIHAR.md`, `BIHAR-GRAPH.md`), delete them:

```bash
rm -f BIHAR.md BIHAR-GRAPH.md
```

### Step 6: Update README.md

Update the Results section in `README.md` with a table linking to the new state summary files. Use `%20` for spaces in directory names:

```markdown
## Results — Assembly Elections May 2026

| State | Tabular | Graphical |
| --- | --- | --- |
| Assam | [Assam.md](result/ASSAM/Assam.md) | [Assam-GRAPH.md](result/ASSAM/Assam-GRAPH.md) |
| Kerala | [Kerala.md](result/KERALA/Kerala.md) | [Kerala-GRAPH.md](result/KERALA/Kerala-GRAPH.md) |
| Puducherry | [Puducherry.md](result/PUDUCHERRY/Puducherry.md) | [Puducherry-GRAPH.md](result/PUDUCHERRY/Puducherry-GRAPH.md) |
| Tamil Nadu | [Tamil Nadu.md](result/TAMIL%20NADU/Tamil%20Nadu.md) | [Tamil Nadu-GRAPH.md](result/TAMIL%20NADU/Tamil%20Nadu-GRAPH.md) |
| West Bengal | [West Bengal.md](result/WEST%20BENGAL/West%20Bengal.md) | [West Bengal-GRAPH.md](result/WEST%20BENGAL/West%20Bengal-GRAPH.md) |
```

### Step 7: Commit

Stage and commit all changes — generated markdown, generate.sh, templates, README, and deleted legacy files.

## Known Gotchas

- **TOC anchor spaces**: GitHub generates anchors with hyphens for spaces. The `display_anchor` variable (not `${display,,}`) must be used for TOC links. `${display,,}` only lowercases but preserves spaces.
- **Party name sed ordering**: In `shorten_party`, longer party names must appear before shorter substrings (e.g., `All India Anna Dravida Munnetra Kazhagam` → `AIADMK` before `Dravida Munnetra Kazhagam` → `DMK`).
- **Array reversal**: Use proper bash array loop `for((i=${#arr[@]}-1;i>=0;i--))` instead of word-splitting subshells.
- **CSV parsing with `cut -d','`**: Does not handle embedded commas in quoted fields. No such fields have been found in current data, but this could break with new data.
- **bc integer truncation**: Expressions like `$val * 1.2 / 1` use `bc` which truncates to integer. This is intentional for y-axis ranges.
- **macOS sed**: The `prettify_col` function uses `awk` for title-casing because macOS `sed` doesn't support `\b` word boundaries.

## Key Files

| File | Purpose |
| --- | --- |
| `result/generate.sh` | Single source of truth; generates all STATE.md and STATE-GRAPH.md files |
| `result/TEMPLATE.md` | Reference template with `{{PLACEHOLDER}}` markers for tabular markdown |
| `result/TEMPLATE-GRAPH.md` | Reference template with `{{PLACEHOLDER}}` markers for graphical markdown |
| `result/<STATE>/<Display>.md` | Generated tabular summary per state |
| `result/<STATE>/<Display>-GRAPH.md` | Generated graphical summary per state (mermaid charts) |
| `README.md` | Links to all state result files |
