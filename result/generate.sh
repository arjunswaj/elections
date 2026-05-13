#!/usr/bin/env bash
set -euo pipefail

# ── Configuration ──────────────────────────────────────────────────────────
RESULT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$RESULT_DIR")"

STATES=("ASSAM" "KERALA" "PUDUCHERRY" "TAMIL NADU" "WEST BENGAL")
STATE_DISPLAY=("Assam" "Kerala" "Puducherry" "Tamil Nadu" "West Bengal")
STATE_MONTH=("May-2026" "May-2026" "May-2026" "May-2026" "May-2026")
STATE_MONTH_DISPLAY=("May 2026" "May 2026" "May 2026" "May 2026" "May 2026")
STATE_YEAR=("2026" "2026" "2026" "2026" "2026")

# Helper: read CSV, return body rows (skip header)
csv_body() { tail -n +2 "$1"; }
# Helper: top N rows from CSV body
csv_top() { csv_body "$1" | head -n "${2:-5}"; }
# Helper: bottom N rows from CSV body
csv_bottom() { csv_body "$1" | tail -n "${2:-5}"; }

# Helper: prettify a CSV column name (replace underscores, title-case words)
prettify_col() {
  echo "$1" | tr '_' ' ' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1))tolower(substr($i,2))}; print}' | \
    sed 's/^Hhi /HHI /g' | \
    sed 's/No Of/Number of/g' | \
    sed 's/Vote Share/Vote Share/g' | \
    sed 's/Runner Up/Runner Up/g' | \
    sed 's/Winner Party/Winning Party/g' | \
    sed 's/Runner Up Party/Runner Up Party/g' | \
    sed 's/Vote Difference/Vote Difference/g' | \
    sed 's/Runner Up Votes/Runner Up Votes/g' | \
    sed 's/Winning Votes/Winning Votes/g' | \
    sed 's/Constituency Code/Code/g' | \
    sed 's/Runner Up Vote Pct/Runner Up %/g' | \
    sed 's/Party Avg Vote Pct/Party Avg %/g' | \
    sed 's/Overperformance Pct/Overperformance %/g' | \
    sed 's/Third Place Vote Pct/Third Place %/g' | \
    sed 's/Others Vote Pct/Others Vote %/g' | \
    sed 's/Total Constested At/Constituencies/g' | \
    sed 's/Total Candidates/Candidates/g' | \
    sed 's/Constituency Count/Constituencies Contested/g' | \
    sed 's/No Of Candidates With Less Than One Sixth Votes/Seats < 1\/6 Vote Share/g' | \
    sed 's/Crowding Band/Crowding Band/g' | \
    sed 's/Postal Vote Gap/Postal Vote Gap/g' | \
    sed 's/Runner Up Vote Percentage/Runner Up Vote %/g' | \
    sed 's/Seats Participated/Seats Contested/g' | \
    sed 's/Success Ratio/Success Ratio/g' | \
    sed 's/Seats Participated/Seats Contested/g' | \
    sed 's/Seats Won/Seats Won/g' | \
    sed 's/Silver Medals/Silver Medals/g' | \
    sed 's/Party Votes/Party Votes/g' | \
    sed 's/Cost Per Vote/Cost per Vote/g' | \
    sed 's/Total Cost/Total Spent/g' | \
    sed 's/Margin Votes/Margin Votes/g' | \
    sed 's/Margin Pct/Margin %/g'
}

# Helper: format CSV rows as markdown table (auto-columns from header)
csv_to_md() {
  local file="$1" rows="${2:-5}" take_top="${3:-1}"
  local header
  header=$(head -1 "$file")
  local cols
  cols=$(echo "$header" | awk -F',' '{print NF}')
  # Build header line with prettified names
  local md_header="|"
  for i in $(seq 1 "$cols"); do
    local col
    col=$(echo "$header" | cut -d',' -f"$i" | tr -d '"')
    col=$(prettify_col "$col")
    md_header="$md_header $col |"
  done
  # Build separator
  local md_sep="|"
  for i in $(seq 1 "$cols"); do
    md_sep="$md_sep --- |"
  done
  echo "$md_header"
  echo "$md_sep"
  # Build data rows
  local data
  if [ "$take_top" -eq 1 ]; then
    data=$(csv_top "$file" "$rows")
  else
    data=$(csv_bottom "$file" "$rows")
  fi
  if [ -n "$data" ]; then
    echo "$data" | while IFS= read -r line; do
      local md_row="|"
      for i in $(seq 1 "$cols"); do
        local val
        val=$(echo "$line" | cut -d',' -f"$i" | tr -d '"')
        md_row="$md_row $val |"
      done
      echo "$md_row"
    done
  fi
}

# Helper: format Success Ratio CSV (skip rows with empty seats_won column)
csv_to_md_success() {
  local file="$1" rows="${2:-5}" take_top="${3:-1}"
  local header
  header=$(head -1 "$file")
  local cols
  cols=$(echo "$header" | awk -F',' '{print NF}')
  # seats_won is column 3; filter non-empty
  local md_header="|"
  for i in $(seq 1 "$cols"); do
    local col
    col=$(echo "$header" | cut -d',' -f"$i" | tr -d '"')
    col=$(prettify_col "$col")
    md_header="$md_header $col |"
  done
  local md_sep="|"
  for i in $(seq 1 "$cols"); do
    md_sep="$md_sep --- |"
  done
  echo "$md_header"
  echo "$md_sep"
  # Filter rows where column 3 (seats_won) is non-empty
  local data
  data=$(csv_body "$file" | awk -F',' '$3 != "" && $3 != 0')
  if [ "$take_top" -eq 1 ]; then
    data=$(echo "$data" | head -n "$rows")
  else
    data=$(echo "$data" | tail -n "$rows")
  fi
  if [ -n "$data" ]; then
    echo "$data" | while IFS= read -r line; do
      local md_row="|"
      for i in $(seq 1 "$cols"); do
        local val
        val=$(echo "$line" | cut -d',' -f"$i" | tr -d '"')
        md_row="$md_row $val |"
      done
      echo "$md_row"
    done
  fi
}

# Helper: truncate vote_share decimals to 2 places for display
format_vote_share() {
  echo "$1" | awk -F'.' '{if(NF>1) printf "%s.%.2s", $1, $2; else print $0}'
}

# Helper: shorten party name for chart labels
shorten_party() {
  echo "$1" | sed \
    -e 's/Bharatiya Janata Party/BJP/g' \
    -e 's/Indian National Congress/INC/g' \
    -e 's/Rashtriya Janata Dal/RJD/g' \
    -e 's/Janata Dal (United)/JD(U)/g' \
    -e 's/Lok Janshakti Party (Ram Vilas)/LJP(RV)/g' \
    -e 's/All India Trinamool Congress/AITC/g' \
    -e 's/Communist Party of India (Marxist-Leninist) (Liberation)/CPI(ML)/g' \
    -e 's/Communist Party of India (Marxist)/CPI(M)/g' \
    -e 's/Communist Party of India/CPI/g' \
    -e 's/All India United Democratic Front/AIUDF/g' \
    -e 's/Asom Gana Parishad/AGP/g' \
    -e 's/Indian Union Muslim League/IUML/g' \
    -e 's/All India Anna Dravida Munnetra Kazhagam/AIADMK/g' \
    -e 's/Dravida Munnetra Kazhagam/DMK/g' \
    -e 's/Tamilaga Vettri Kazhagam/TVK/g' \
    -e 's/All India N.R. Congress/AINRC/g' \
    -e 's/Bahujan Samaj Party/BSP/g' \
    -e 's/Bodoland Peoples Front/BPF/g' \
    -e 's/None of the Above/NOTA/g' \
    -e 's/Jan Suraaj Party/Jan Suraaj/g' \
    -e 's/Assam Jatiya Parishad/AJP/g' \
    -e 's/Viduthalai Chiruthaigal Katchi/VCK/g' \
    -e 's/Pattali Makkal Katchi/PMK/g' \
    -e 's/Naam Tamilar Katchi/NTK/g' \
    -e 's/Desiya Murpokku Dravida Kazhagam/DMDK/g' \
    -e 's/Amma Makkal Munnettra Kazagam/AMMK/g' \
    -e 's/Marxist-Leninist/ML/g'
}

# ── Per-state party list for TOC ───────────────────────────────────────────
party_toc_entries() {
  local dir="$1"
  for f in "$dir"/19\ Party\ Specific\ -\ *.csv; do
    local party
    party=$(basename "$f" .csv | sed 's/19 Party Specific - //')
    echo "    * [$party](#$(echo "$party" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-'))"
  done
}

# ── Generate STATE.md ──────────────────────────────────────────────────────
generate_state_md() {
  local idx="$1" state="${STATES[$idx]}" display="${STATE_DISPLAY[$idx]}" month="${STATE_MONTH[$idx]}" month_display="${STATE_MONTH_DISPLAY[$idx]}" year="${STATE_YEAR[$idx]}"
  local dir="$RESULT_DIR/$state"
  local display_anchor
  display_anchor=$(echo "$display" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  local total_candidates total_votes

  total_candidates=$(head -1 "$dir/01 Number Of Candidates by State.csv" | tail -1)
  # CSV has header then value
  total_candidates=$(csv_body "$dir/01 Number Of Candidates by State.csv" | head -1 | tr -d '"')
  total_votes=$(csv_body "$dir/01 Number Of Votes.csv" | head -1 | tr -d '"')

  # Count registered parties (excl Independent & NOTA from All Parties list)
  local registered_parties
  registered_parties=$(csv_body "$dir/12 All Parties.csv" | grep -cv -e "Independent" -e "None of the Above")

  # Votes in crores
  local votes_crore
  votes_crore=$(echo "scale=2; $total_votes / 10000000" | bc)

  cat <<HEADER
# Table of contents

- [Analysis of ${display} Assembly Elections ${month_display}](#analysis-of-${display_anchor}-assembly-elections-${month,,})
* [Analysis](#analysis)
+ [Seats contested by Parties](#seats-contested-by-parties)
+ [Max and Mins](#max-and-mins)
- [Maximum votes for a candidate](#maximum-votes-for-a-candidate)
- [Least votes for a winning candidate](#least-votes-for-a-winning-candidate)
- [Max votes for a losing candidate](#max-votes-for-a-losing-candidate)
- [Candidates winning by Max margin (Unilateral winner)](#candidates-winning-by-max-margin--unilateral-winner-)
- [Candidates winning by Least margin (Fierce battle)](#candidates-winning-by-least-margin--fierce-battle-)
+ [Max and Mins - Constituencies](#max-and-mins---constituencies)
- [Max Total Votes in a Constituency](#max-total-votes-in-a-constituency)
- [Min Total Votes Constituency](#min-total-votes-constituency)
- [Max candidates in a Constituency](#max-candidates-in-a-constituency)
- [Least candidates in a Constituency](#least-candidates-in-a-constituency)
+ [Vote Shares](#vote-shares)
- [Total Vote Share of Parties](#total-vote-share-of-parties)
- [Maximum Vote share for a winning candidate](#maximum-vote-share-for-a-winning-candidate)
- [Least Vote share for a winning candidate](#least-vote-share-for-a-winning-candidate)
- [Max Vote share of a losing candidate](#max-vote-share-of-a-losing-candidate)
- [Seats in which Parties lost deposits (less than 1/6 vote share)](#seats-in-which-parties-lost-deposits--less-than-1-6-vote-share-)
+ [Medals](#medals)
- [Gold (Seats that Parties won)](#gold--seats-that-parties-won-)
- [Silver (Seats that Parties came in second)](#silver--seats-that-parties-came-in-second-)
+ [Strike Rates](#strike-rates)
- [Cost per vote - Best Value per vote](#cost-per-vote---best-value-per-vote)
- [Cost per vote - Worst Value per vote](#cost-per-vote---worst-value-per-vote)
- [Success Ratio](#success-ratio)
+ [Multiple Seat Participation](#multiple-seat-participation)
- [Candidates participating in multiple seats (matches names)](#candidates-participating-in-multiple-seats--matches-names-)
- [Results of Candidates participating in multiple seats](#results-of-candidates-participating-in-multiple-seats)
+ [Close Contest Matrix](#close-contest-matrix)
- [Party Specific Close Contest Matrix](#party-specific-close-contest-matrix)
$(party_toc_entries "$dir" | sed 's/^/ /')
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of ${display} Assembly Elections ${month_display}

The ${year} ${display} Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting and results declared by the Election Commission of India.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/${state}).

## Analysis
A total of ${total_candidates} candidates contested in the ${display} assembly elections and about ${votes_crore} Crore (\`${total_votes}\`) votes were cast during this period. Excluding Independents and NOTA, ${registered_parties} registered parties featured on the ballot—from the big alliances.

### Seats contested by Parties

$(csv_to_md "$dir/01 Number Of Candidates.csv" 10 1)

### Max and Mins

#### Maximum votes for a candidate

$(csv_to_md "$dir/02 Maximum Votes for a Candidate.csv" 5 1)

#### Least votes for a winning candidate

$(csv_to_md "$dir/03 Least votes for a winning candidate.csv" 5 1)

#### Max votes for a losing candidate

$(csv_to_md "$dir/04 Max votes for a losing candidate.csv" 5 1)

#### Candidates winning by Max margin (Unilateral winner)

$(csv_to_md "$dir/05 Candidates winning by Max or Min margin.csv" 5 1)

#### Candidates winning by Least margin (Fierce battle)

$(csv_to_md "$dir/05 Candidates winning by Max or Min margin.csv" 5 0)

### Max and Mins - Constituencies
#### Max Total Votes in a Constituency

$(csv_to_md "$dir/06 Max Total Votes in Constituency.csv" 5 1)

#### Min Total Votes Constituency

$(csv_to_md "$dir/06 Max Total Votes in Constituency.csv" 5 0)

#### Max candidates in a Constituency

$(csv_to_md "$dir/07 Max Candidates in a Constituency.csv" 5 1)

#### Least candidates in a Constituency

$(csv_to_md "$dir/07 Max Candidates in a Constituency.csv" 5 0)

### Vote Shares

#### Total Vote Share of Parties

$(csv_to_md "$dir/08 Total Vote Share.csv" 5 1)

#### Maximum Vote share for a winning candidate

$(csv_to_md "$dir/09 Least Vote share of Winning Candidate.csv" 5 0)

#### Least Vote share for a winning candidate

$(csv_to_md "$dir/09 Least Vote share of Winning Candidate.csv" 5 1)

#### Max Vote share of a losing candidate

$(csv_to_md "$dir/10 Max Vote share of a losing candidate.csv" 5 1)

#### Seats in which Parties lost deposits (less than 1/6 vote share)

$(csv_to_md "$dir/11 LOST Deposits.csv" 5 1)

### Medals

#### Gold (Seats that Parties won)

$(csv_to_md "$dir/12 Gold.csv" 5 1)

#### Silver (Seats that Parties came in second)

$(csv_to_md "$dir/13 Silver.csv" 5 1)

### Strike Rates

#### Cost per vote - Best Value per vote

$(csv_to_md "$dir/14 Cost per vote.csv" 5 1)

#### Cost per vote - Worst Value per vote

$(csv_to_md "$dir/14 Cost per vote.csv" 5 0)

#### Success Ratio

$(csv_to_md_success "$dir/14 Success Ratio.csv" 5 0)

#### Success Ratio - Worst (At least 1 Win)

$(csv_to_md "$dir/15 Strike Rate - Worst (At least 1 Win).csv" 5 1)

### Multiple Seat Participation

#### Candidates participating in multiple seats (matches names)

$(csv_to_md "$dir/16 Multiple Participation.csv" 10 1)

#### Results of Candidates participating in multiple seats

$(csv_to_md "$dir/17 Multiple Participation Results.csv" 10 1)

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

$(csv_to_md "$dir/18 Close Contest Matrix.csv" 10 1)

#### Party Specific Close Contest Matrix
HEADER

  # Party-specific sections
  for f in "$dir"/19\ Party\ Specific\ -\ *.csv; do
    local party
    party=$(basename "$f" .csv | sed 's/19 Party Specific - //')
    echo ""
    echo "##### $party"
    echo ""
    csv_to_md "$f" 5 1
    echo ""
  done

  cat <<FOOTER

### Advanced Join Insights

The following highlights rely on multi-layer joins that combine margin, vote-share distribution, and competition intensity. Full result sets are saved in \`result/${state}/22 Crowding Pressure Seats.csv\`, \`result/${state}/23 Runner Up Overperformance.csv\`, \`result/${state}/24 HHI Win Mix.csv\`, and \`result/${state}/25 Third Place Spoilers.csv\`.

#### Crowding pressure seats

Seats where narrow margins collide with double-digit "others" vote share signal the highest volatility. Postal vote gaps are included to show where mailed ballots could tip the balance.

$(csv_to_md "$dir/22 Crowding Pressure Seats.csv" 5 1)

#### Runner-up overperformance vs party baseline

Comparing runner-up vote share with each party's average reveals hidden pockets of strength despite losses.

$(csv_to_md "$dir/23 Runner Up Overperformance.csv" 5 1)

#### HHI win mix by party

HHI bands group constituencies by vote concentration, illustrating which parties thrive in dominant versus competitive environments.

$(csv_to_md "$dir/24 HHI Win Mix.csv" 10 1)

#### Third-place spoilers in tight races

Third-place performers who beat their party's customary share often decide the margins in knife-edge seats.

$(csv_to_md "$dir/25 Third Place Spoilers.csv" 5 1)
FOOTER
}

# ── Generate STATE-GRAPH.md ────────────────────────────────────────────────
generate_state_graph_md() {
  local idx="$1" state="${STATES[$idx]}" display="${STATE_DISPLAY[$idx]}" month="${STATE_MONTH[$idx]}" month_display="${STATE_MONTH_DISPLAY[$idx]}" year="${STATE_YEAR[$idx]}"
  local dir="$RESULT_DIR/$state"
  local display_anchor
  display_anchor=$(echo "$display" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  local total_candidates total_votes

  total_candidates=$(csv_body "$dir/01 Number Of Candidates by State.csv" | head -1 | tr -d '"')
  total_votes=$(csv_body "$dir/01 Number Of Votes.csv" | head -1 | tr -d '"')
  local votes_crore
  votes_crore=$(echo "scale=2; $total_votes / 10000000" | bc)

  # ── Helper: extract column values for mermaid charts ──
  # csv_col_values <file> <col_num> <n_rows> <top_or_bottom>
  csv_col_values() {
    local file="$1" col="$2" n="$3" top="${4:-1}"
    if [ "$top" -eq 1 ]; then
      csv_top "$file" "$n" | cut -d',' -f"$col" | tr -d '"'
    else
      csv_bottom "$file" "$n" | cut -d',' -f"$col" | tr -d '"'
    fi
  }

  # ── Build mermaid xychart-beta ──
  # make_bar_chart <title> <file> <label_cols(comma)> <value_col> <n> <top> <y_min> <y_max>
  make_bar_chart() {
    local title="$1" file="$2" label_cols="$3" value_col="$4" n="$5" top="$6" y_min="$7" y_max="$8"
    local labels_str values_str

    # Build labels from possibly multiple columns
    local data_rows
    if [ "$top" -eq 1 ]; then
      data_rows=$(csv_top "$file" "$n")
    else
      data_rows=$(csv_bottom "$file" "$n")
    fi

    local labels=()
    local values=()
    while IFS= read -r line; do
      local label=""
      local IFS_old="$IFS"
      IFS=','
      local parts=($line)
      IFS="$IFS_old"
      # Build label from specified columns
      local cols_arr=(${label_cols//,/ })
      local label_parts=()
      for c in "${cols_arr[@]}"; do
        label_parts+=("$(echo "$line" | cut -d',' -f"$c" | tr -d '"')")
      done
      # Join label parts with " "
      local joined=""
      for p in "${label_parts[@]}"; do
        if [ -n "$joined" ]; then joined="$joined $p"; else joined="$p"; fi
      done
      labels+=("$joined")
      values+=("$(echo "$line" | cut -d',' -f"$value_col" | tr -d '"')")
    done <<< "$data_rows"

    # Format labels as JSON-like array for mermaid
    local label_str=""
    for l in "${labels[@]}"; do
      # Truncate long labels for readability
      local short
      short=$(echo "$l" | cut -c1-40)
      if [ -n "$label_str" ]; then label_str="$label_str, \"$short\""; else label_str="\"$short\""; fi
    done
    # Format values
    local val_str=""
    for v in "${values[@]}"; do
      # Round to integer for display if it's a float
      local vint
      vint=$(echo "$v" | awk '{printf "%.0f", $1}')
      if [ -n "$val_str" ]; then val_str="$val_str, $vint"; else val_str="$vint"; fi
    done

    cat <<CHART
\`\`\`mermaid
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
title "$title"
x-axis [$label_str]
y-axis "$title" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  cat <<GHEADER
# Table of contents

- [Analysis of ${display} Assembly Elections ${month_display}](#analysis-of-${display_anchor}-assembly-elections-${month,,})
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
$(party_toc_entries "$dir" | sed 's/^/ /')
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of ${display} Assembly Elections ${month_display}

The ${year} ${display} Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting overseen by the Election Commission of India soon after polling.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/${state}).

## Analysis
A total of ${total_candidates} candidates contested in the ${display} assembly elections and about ${votes_crore} Crore (\`${total_votes}\`) votes were cast during this period.
GHEADER

  # ── Seats contested by Parties ──
  echo ""
  echo "### Seats contested by Parties"
  echo ""
  # Build chart data inline
  {
    local n=10
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_top "$dir/01 Number Of Candidates.csv" "$n")

    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done

    local y_max
    y_max=$(echo "${values[0]} * 1.2 / 1" | bc)

    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Seats" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # ── Max and Mins ──
  echo ""
  echo "### Max and Mins"
  echo ""

  # Maximum votes for a candidate (02 Maximum Votes for a Candidate)
  echo "#### Maximum votes for a candidate"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local cand party const val
      cand=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      party=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f6 | tr -d '"')
      labels+=("$(echo "$cand ($(shorten_party "$party"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_top "$dir/02 Maximum Votes for a Candidate.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[-1]} * 0.9 / 1" | bc)
    y_max=$(echo "${values[0]} * 1.1 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Votes" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Least votes for a winning candidate
  echo ""
  echo "#### Least votes for a winning candidate"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local cand party const val
      cand=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      party=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f6 | tr -d '"')
      labels+=("$(echo "$cand ($(shorten_party "$party"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_top "$dir/03 Least votes for a winning candidate.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[0]} * 0.9 / 1" | bc)
    y_max=$(echo "${values[-1]} * 1.1 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Votes" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Max votes for a losing candidate
  echo ""
  echo "#### Max votes for a losing candidate"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local cand party const val
      cand=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      party=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f6 | tr -d '"')
      labels+=("$(echo "$cand ($(shorten_party "$party"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_top "$dir/04 Max votes for a losing candidate.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[-1]} * 0.9 / 1" | bc)
    y_max=$(echo "${values[0]} * 1.1 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Votes" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Candidates winning by Max margin
  echo ""
  echo "#### Candidates winning by Max margin (Unilateral winner)"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local winner wparty const val
      winner=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      wparty=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f9 | tr -d '"')
      labels+=("$(echo "$winner ($(shorten_party "$wparty"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_top "$dir/05 Candidates winning by Max or Min margin.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[-1]} * 0.9 / 1" | bc)
    y_max=$(echo "${values[0]} * 1.1 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Vote Difference" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Candidates winning by Least margin
  echo ""
  echo "#### Candidates winning by Least margin (Fierce battle)"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local winner wparty const val
      winner=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      wparty=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f9 | tr -d '"')
      labels+=("$(echo "$winner ($(shorten_party "$wparty"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_bottom "$dir/05 Candidates winning by Max or Min margin.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=0
    y_max=$(echo "${values[-1]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Vote Difference" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # ── Constituencies ──
  echo ""
  echo "#### Max Total Votes in a Constituency"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const st val
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      st=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      labels+=("$const ($st)")
      values+=("$val")
    done < <(csv_top "$dir/06 Max Total Votes in Constituency.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[-1]} * 0.9 / 1" | bc)
    y_max=$(echo "${values[0]} * 1.1 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Total Votes" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  echo ""
  echo "#### Min Total Votes Constituency"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const st val
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      st=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      labels+=("$const ($st)")
      values+=("$val")
    done < <(csv_bottom "$dir/06 Max Total Votes in Constituency.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[0]} * 0.9 / 1" | bc)
    y_max=$(echo "${values[-1]} * 1.1 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Total Votes" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  echo ""
  echo "#### Max Candidates in a Constituency"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const st val
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      st=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      labels+=("$const ($st)")
      values+=("$val")
    done < <(csv_top "$dir/07 Max Candidates in a Constituency.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[0]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Candidates" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  echo ""
  echo "#### Least Candidates in a Constituency"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const st val
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      st=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"')
      labels+=("$const ($st)")
      values+=("$val")
    done < <(csv_bottom "$dir/07 Max Candidates in a Constituency.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[-1]} * 2 / 1" | bc)
    [ "$y_max" -lt 10 ] && y_max=10
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Candidates" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # ── Vote Shares ──
  echo ""
  echo "#### Total Vote Share of Parties"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      # Truncate vote share to 2 decimal places
      val=$(echo "$val" | awk '{printf "%.2f", $1}')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_top "$dir/08 Total Vote Share.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    cat <<CHART
\`\`\`mermaid
pie title Total Vote Share of Parties
$(for i in "${!labels[@]}"; do echo "  \"${labels[$i]}\" : ${values[$i]}"; done)
\`\`\`
CHART
  }

  # Maximum Vote share of Winning Candidate (from 09 - bottom 5 = highest vote share)
  echo ""
  echo "#### Maximum Vote Share of Winning Candidate"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local cand party const val
      cand=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      party=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$(echo "$cand ($(shorten_party "$party"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_bottom "$dir/09 Least Vote share of Winning Candidate.csv" "$n")
  # Reverse to show highest first
  local rev_labels=() rev_values=()
  for((i=${#labels[@]}-1;i>=0;i--)); do rev_labels+=("${labels[$i]}"); rev_values+=("${values[$i]}"); done
  labels=("${rev_labels[@]}")
  values=("${rev_values[@]}")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[-1]} - 5" | bc)
    y_max=$(echo "${values[0]} + 5" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Vote Share" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Least Vote Share for a Winning Candidate (from 09 - top 5 = lowest vote share)
  echo ""
  echo "#### Least Vote Share for a Winning Candidate"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local cand party const val
      cand=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      party=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$(echo "$cand ($(shorten_party "$party"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_top "$dir/09 Least Vote share of Winning Candidate.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[0]} - 5" | bc)
    y_max=$(echo "${values[-1]} + 5" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Vote Share" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Max Vote Share of a Losing Candidate
  echo ""
  echo "#### Max Vote Share of a Losing Candidate"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local cand party const val
      cand=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      party=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      const=$(echo "$line" | cut -d',' -f3 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$(echo "$cand ($(shorten_party "$party"), $const)" | cut -c1-60)")
      values+=("$val")
    done < <(csv_top "$dir/10 Max Vote share of a losing candidate.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_min y_max
    y_min=$(echo "${values[-1]} - 5" | bc)
    y_max=$(echo "${values[0]} + 5" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Vote Share" $y_min --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Lost Deposits
  echo ""
  echo "#### Seats in which Parties Lost Deposits (less than 1/6 vote share)"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_top "$dir/11 LOST Deposits.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[0]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Seats" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Gold
  echo ""
  echo "#### Gold (Seats that Parties Won)"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_top "$dir/12 Gold.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[0]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Seats" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Silver
  echo ""
  echo "#### Silver (Seats that Parties Came in Second)"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_top "$dir/13 Silver.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[0]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Number of Seats" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Cost per vote - Best
  echo ""
  echo "#### Cost per Vote - Best Value"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_top "$dir/14 Cost per vote.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[-1]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Cost per Vote" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Cost per vote - Worst
  echo ""
  echo "#### Cost per Vote - Worst Value"
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local party val
      party=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f4 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$(shorten_party "$party")")
      values+=("$val")
    done < <(csv_bottom "$dir/14 Cost per vote.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    local y_max
    y_max=$(echo "${values[-1]} * 1.2 / 1" | bc)
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Cost per Vote" 0 --> $y_max
bar [$val_str]
\`\`\`
CHART
  }

  # Success Ratio - Best (from 14 Success Ratio.csv, bottom rows with non-empty seats_won)
  echo ""
  echo "#### Success Ratio - Best"
  echo ""
  echo ""
  csv_to_md_success "$dir/14 Success Ratio.csv" 5 0

  # Success Ratio - Worst
  echo ""
  echo "#### Success Ratio - Worst"
  echo ""
  echo ""
  csv_to_md "$dir/15 Strike Rate - Worst (At least 1 Win).csv" 5 1

  # Multiple Seat Participation
  echo ""
  echo "### Multiple Seat Participation"
  echo ""
  echo "#### Results of Candidates participating in multiple seats"
  echo ""
  csv_to_md "$dir/17 Multiple Participation Results.csv" 10 1

  # Close Contest Matrix
  echo ""
  echo "### Close Contest Matrix"
  echo "This matrix provides the number of seats in which parties lost by the number of votes provided in the columns."
  echo ""
  csv_to_md "$dir/18 Close Contest Matrix.csv" 10 1

  # Party Specific Close Contest Matrix
  echo ""
  echo "#### Party Specific Close Contest Matrix"
  echo ""
  for f in "$dir"/19\ Party\ Specific\ -\ *.csv; do
    local party
    party=$(basename "$f" .csv | sed 's/19 Party Specific - //')
    echo ""
    echo "##### $party"
    echo ""
    csv_to_md "$f" 5 1
    echo ""
  done

  # ── Advanced Join Insights ──
  echo ""
  echo "### Advanced Join Insights"
  echo ""

  # Crowding pressure
  echo "#### Crowding pressure seats"
  echo ""
  echo "Crowded ballots with thin margins are visualized below using \"others\" vote share as a proxy for fragmentation."
  echo ""
  csv_to_md "$dir/22 Crowding Pressure Seats.csv" 5 1
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const val
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f6 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$const")
      values+=("$val")
    done < <(csv_top "$dir/22 Crowding Pressure Seats.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Others Vote %" 0 --> 50
bar [$val_str]
\`\`\`
CHART
  }

  # Runner-up overperformance
  echo ""
  echo "#### Runner-up overperformance vs party baseline"
  echo ""
  echo "These runner-up candidates beat their party-wide average vote share even in defeat."
  echo ""
  csv_to_md "$dir/23 Runner Up Overperformance.csv" 5 1
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const val
      const=$(echo "$line" | cut -d',' -f1 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f6 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$const")
      values+=("$val")
    done < <(csv_top "$dir/23 Runner Up Overperformance.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Overperformance %" 0 --> 35
bar [$val_str]
\`\`\`
CHART
  }

  # HHI win mix
  echo ""
  echo "#### HHI win mix by party"
  echo ""
  echo "Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types."
  echo ""
  csv_to_md "$dir/24 HHI Win Mix.csv" 10 1
  echo ""
  {
    # Build stacked bar chart: x-axis = HHI bands, bars = parties
    local hhi_file="$dir/24 HHI Win Mix.csv"
    # Get unique bands
    local bands
    bands=$(csv_body "$hhi_file" | cut -d',' -f2 | tr -d '"' | sort -u)
    # Get top 5 parties by total seats
    local top_parties
    top_parties=$(csv_body "$hhi_file" | awk -F',' '{seats[$1]+=$3} END {for(p in seats) print p, seats[p]}' | sort -k2 -nr | head -5 | awk '{print $1}')

    # Build data for each party × band
    local band_arr=()
    for b in $bands; do
      band_arr+=("$b")
    done

    local party_arr=()
    while IFS= read -r p; do
      party_arr+=("$p")
    done <<< "$top_parties"

    # x-axis labels
    local x_labels=""
    for b in "${band_arr[@]}"; do
      if [ -n "$x_labels" ]; then x_labels="$x_labels, \"$b\""; else x_labels="\"$b\""; fi
    done

    # Build bar lines for each party
    local bar_lines=""
    for p in "${party_arr[@]}"; do
      local short_p
      short_p=$(shorten_party "$p")
      local vals=""
      for b in "${band_arr[@]}"; do
        local seats
        seats=$(csv_body "$hhi_file" | awk -F',' -v p="$p" -v b="$b" '$1==p && $2==b {print $3}' | tr -d '"' | head -1)
        [ -z "$seats" ] && seats=0
        if [ -n "$vals" ]; then vals="$vals, $seats"; else vals="$seats"; fi
      done
      if [ -n "$bar_lines" ]; then bar_lines="${bar_lines}\nbar \"$short_p\" [$vals]"; else bar_lines="bar \"$short_p\" [$vals]"; fi
    done

    cat <<CHART
\`\`\`mermaid
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
x-axis [$x_labels]
y-axis "Seats Won" 0 --> 100
$(echo -e "$bar_lines")
\`\`\`
CHART
  }

  # Third-place spoilers
  echo ""
  echo "#### Third-place spoilers in tight races"
  echo ""
  echo "Third-place candidacies that materially exceeded their party's norm highlight potential spoiler roles."
  echo ""
  {
    local n=5
    local labels=() values=()
    while IFS= read -r line; do
      local const val
      const=$(echo "$line" | cut -d',' -f2 | tr -d '"')
      val=$(echo "$line" | cut -d',' -f7 | tr -d '"' | awk '{printf "%.2f", $1}')
      labels+=("$const")
      values+=("$val")
    done < <(csv_top "$dir/25 Third Place Spoilers.csv" "$n")
    local label_str="" val_str=""
    for l in "${labels[@]}"; do
      if [ -n "$label_str" ]; then label_str="$label_str, \"$l\""; else label_str="\"$l\""; fi
    done
    for v in "${values[@]}"; do
      if [ -n "$val_str" ]; then val_str="$val_str, $v"; else val_str="$v"; fi
    done
    cat <<CHART
\`\`\`mermaid
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
x-axis [$label_str]
y-axis "Overperformance %" 0 --> 25
bar [$val_str]
\`\`\`
CHART
  }
}

# ── Main ───────────────────────────────────────────────────────────────────
echo "Generating markdown files for all states..."
for idx in "${!STATES[@]}"; do
  state="${STATES[$idx]}"
  display="${STATE_DISPLAY[$idx]}"
  echo "  $display..."
  generate_state_md "$idx" > "$RESULT_DIR/$state/$display.md"
  generate_state_graph_md "$idx" > "$RESULT_DIR/$state/$display-GRAPH.md"
done
echo "Done."
