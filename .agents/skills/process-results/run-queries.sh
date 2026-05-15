#!/usr/bin/env bash
# run-queries.sh — Run all SQL queries against PostgreSQL, filtered per state, export as CSV
# Excludes constituencies marked as EXCLUDE in the election_gates table
# Usage: bash .agents/skills/process-results/run-queries.sh [--state <STATE>]
# Without --state: runs all configured states
# With --state: runs only the specified state (directory name, e.g. ASSAM)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
QUERIES_DIR="$REPO_ROOT/queries"
RESULT_DIR="$REPO_ROOT/result"

STATES=("ASSAM" "KERALA" "PUDUCHERRY" "TAMIL NADU" "WEST BENGAL")
STATE_DISPLAY=("ASSAM" "KERALA" "PUDUCHERRY" "TAMIL NADU" "WEST BENGAL")

PSQL_CONN="${PSQL_CONN:--h 192.168.64.3 -U arjunswaj -d elections}"
TABLE="assembly_elections_may2026"

# ── Parse args ────────────────────────────────────────────────────────────
TARGET_STATE=""
if [ "${1:-}" = "--state" ] && [ -n "${2:-}" ]; then
  TARGET_STATE="$2"
fi

# ── Helpers ───────────────────────────────────────────────────────────────
psql_exec() {
  psql "$PSQL_CONN" --no-align --field-separator=, --tuples-only -c "$1" 2>/dev/null
}

psql_csv() {
  local sql="$1" outfile="$2"
  psql "$PSQL_CONN" --no-align --field-separator=, -c "COPY ($sql) TO STDOUT WITH (FORMAT csv, HEADER true)" > "$outfile" 2>/dev/null
}

# Find state index
state_index() {
  local target="$1"
  for i in "${!STATES[@]}"; do
    if [ "${STATES[$i]}" = "$target" ]; then echo "$i"; return; fi
  done
  echo "-1"
}

# ── Per-state query execution ────────────────────────────────────────────
run_queries_for_state() {
  local idx="$1"
  local state="${STATES[$idx]}"
  local display="${STATE_DISPLAY[$idx]}"
  local dir="$RESULT_DIR/$state"
  local EG="LEFT JOIN election_gates eg ON eg.code = a.code AND eg.status = 'EXCLUDE'"
  local EG_WHERE="AND eg.code IS NULL"

  mkdir -p "$dir"
  echo "  Running queries for $display..."

  # ── 01 Number Of Candidates ──────────────────────────────────────────
  psql_csv \
  "SELECT a.PARTY, COUNT(*) AS NO_OF_CANDIDATES FROM $TABLE a $EG WHERE a.STATE = '$display' AND a.CANDIDATE <> 'NOTA' $EG_WHERE GROUP BY a.PARTY ORDER BY NO_OF_CANDIDATES DESC" \
  "$dir/01 Number Of Candidates.csv"

  # Statement 1: Total votes
  psql_csv \
  "SELECT SUM(a.VOTES) AS NO_OF_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE" \
  "$dir/01 Number Of Votes.csv"

  # Statement 2: Total candidates
  psql_csv \
  "SELECT COUNT(*) AS NO_OF_CANDIDATES FROM $TABLE a $EG WHERE a.STATE = '$display' AND a.CANDIDATE <> 'NOTA' $EG_WHERE" \
  "$dir/01 Number Of Candidates by State.csv"

  # ── 02 Maximum Votes for a Candidate ────────────────────────────────
  psql_csv \
  "SELECT a.CODE AS CONSTITUENCY_CODE, a.CANDIDATE, a.PARTY, a.CONSTITUENCY, a.STATE, a.VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE ORDER BY a.VOTES DESC" \
  "$dir/02 Maximum Votes for a Candidate.csv"

  # ── 02b Max votes of winning candidates
  psql_csv \
  "SELECT t.CODE AS CONSTITUENCY_CODE, t.CANDIDATE, t.PARTY, t.CONSTITUENCY, t.STATE, t.VOTES AS WINNER_VOTES FROM $TABLE t JOIN (SELECT a.CODE, a.CONSTITUENCY, MAX(a.VOTES) AS MAX_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) sub ON t.CODE = sub.CODE AND t.CONSTITUENCY = sub.CONSTITUENCY AND t.VOTES = sub.MAX_VOTES LEFT JOIN election_gates eg2 ON eg2.code = t.code AND eg2.status = 'EXCLUDE' WHERE t.STATE = '$display' AND eg2.code IS NULL ORDER BY t.VOTES DESC" \
  "$dir/02 Max votes of winning candidates.csv"

  # ── 03 Least votes for a winning candidate
  psql_csv \
  "SELECT t.CODE AS CONSTITUENCY_CODE, t.CANDIDATE, t.PARTY, t.CONSTITUENCY, t.STATE, t.VOTES AS WINNER_VOTES FROM $TABLE t JOIN (SELECT a.CODE, a.CONSTITUENCY, MAX(a.VOTES) AS MAX_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) sub ON t.CODE = sub.CODE AND t.CONSTITUENCY = sub.CONSTITUENCY AND t.VOTES = sub.MAX_VOTES LEFT JOIN election_gates eg2 ON eg2.code = t.code AND eg2.status = 'EXCLUDE' WHERE t.STATE = '$display' AND eg2.code IS NULL ORDER BY WINNER_VOTES ASC" \
  "$dir/03 Least votes for a winning candidate.csv"

  # ── 04 Max votes for a losing candidate
  psql_csv \
  "SELECT t2.CODE AS CONSTITUENCY_CODE, t2.CANDIDATE, t2.PARTY, t2.CONSTITUENCY, t2.STATE, t2.VOTES AS RUNNER_VOTES FROM $TABLE t2 JOIN (SELECT t.CODE, t.CONSTITUENCY, MAX(t.VOTES) AS RUNNER_VOTES FROM $TABLE t JOIN (SELECT a.CODE, a.CONSTITUENCY, MAX(a.VOTES) AS MAX_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) sub ON t.CODE = sub.CODE AND t.CONSTITUENCY = sub.CONSTITUENCY AND t.VOTES < sub.MAX_VOTES LEFT JOIN election_gates eg2 ON eg2.code = t.code AND eg2.status = 'EXCLUDE' WHERE t.STATE = '$display' AND eg2.code IS NULL GROUP BY t.CODE, t.CONSTITUENCY) sub2 ON t2.CODE = sub2.CODE AND t2.CONSTITUENCY = sub2.CONSTITUENCY AND t2.VOTES = sub2.RUNNER_VOTES LEFT JOIN election_gates eg3 ON eg3.code = t2.code AND eg3.status = 'EXCLUDE' WHERE t2.STATE = '$display' AND eg3.code IS NULL ORDER BY RUNNER_VOTES DESC" \
  "$dir/04 Max votes for a losing candidate.csv"

  # ── 05 Candidates winning by Max/Min margin
  psql_csv \
  "SELECT c1.CODE AS CONSTITUENCY_CODE, c1.STATE, c1.CONSTITUENCY, c1.CANDIDATE AS WINNER, c1.PARTY AS WINNER_PARTY, c1.VOTES AS WINNER_VOTES, c2.CANDIDATE AS RUNNER_UP, c2.PARTY AS RUNNER_UP_PARTY, c2.VOTES AS RUNNER_UP_VOTES, (c1.VOTES - c2.VOTES) AS VOTE_DIFFERENCE FROM (SELECT a.CODE, a.CONSTITUENCY, a.CANDIDATE, a.PARTY, a.VOTES, a.STATE, ROW_NUMBER() OVER (PARTITION BY a.CODE ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) c1 JOIN (SELECT a.CODE, a.CONSTITUENCY, a.CANDIDATE, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CODE ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) c2 ON c1.CODE = c2.CODE AND c1.CONSTITUENCY = c2.CONSTITUENCY AND c1.rn = 1 AND c2.rn = 2 ORDER BY VOTE_DIFFERENCE ASC" \
  "$dir/05 Candidates winning by Max or Min margin.csv"

  # ── 06 Max Total Votes in Constituency
  psql_csv \
  "SELECT a.CODE AS CONSTITUENCY_CODE, a.CONSTITUENCY, a.STATE, SUM(a.VOTES) AS TOTAL_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY, a.STATE ORDER BY TOTAL_VOTES DESC" \
  "$dir/06 Max Total Votes in Constituency.csv"

  # ── 07 Max Candidates in a Constituency
  psql_csv \
  "SELECT a.CODE AS CONSTITUENCY_CODE, a.CONSTITUENCY, a.STATE, COUNT(a.CANDIDATE) AS NO_OF_CANDIDATES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY, a.STATE ORDER BY NO_OF_CANDIDATES DESC" \
  "$dir/07 Max Candidates in a Constituency.csv"

  # ── 08 Total Vote Share
  psql_csv \
  "SELECT PARTY_VOTE_DETAILS.PARTY, PARTY_VOTE_DETAILS.PARTY_VOTES, (PARTY_VOTE_DETAILS.PARTY_VOTES::numeric / NULLIF(TOTAL_VOTE_DETAILS.TOTAL_VOTES, 0) * 100) AS VOTE_SHARE FROM (SELECT a.PARTY, SUM(a.VOTES) AS PARTY_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.PARTY) AS PARTY_VOTE_DETAILS, (SELECT SUM(a.VOTES) AS TOTAL_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) AS TOTAL_VOTE_DETAILS ORDER BY PARTY_VOTES DESC" \
  "$dir/08 Total Vote Share.csv"

  # ── 09 Least Vote share of Winning Candidate
  psql_csv \
  "SELECT v.CANDIDATE, v.PARTY, v.CONSTITUENCY, v.VOTE_SHARE FROM (SELECT ger.CANDIDATE, ger.PARTY, ger.CONSTITUENCY, ger.VOTES, ger.CODE, VOTE_DETAILS.TOTAL_VOTES, (ger.VOTES::numeric / NULLIF(VOTE_DETAILS.TOTAL_VOTES, 0) * 100) AS VOTE_SHARE FROM (SELECT a.CODE, a.CONSTITUENCY, SUM(a.VOTES) AS TOTAL_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) AS VOTE_DETAILS JOIN $TABLE ger ON VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY AND VOTE_DETAILS.CODE = ger.CODE LEFT JOIN election_gates eg2 ON eg2.code = ger.code AND eg2.status = 'EXCLUDE' WHERE ger.STATE = '$display' AND eg2.code IS NULL) AS v JOIN (SELECT a.CODE, a.CONSTITUENCY, MAX(a.VOTES) AS MAX_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) AS WINNERS ON v.CONSTITUENCY = WINNERS.CONSTITUENCY AND v.CODE = WINNERS.CODE AND v.VOTES = WINNERS.MAX_VOTES ORDER BY VOTE_SHARE ASC" \
  "$dir/09 Least Vote share of Winning Candidate.csv"

  # ── 10 Max Vote share of a losing candidate
  psql_csv \
  "SELECT t2.CANDIDATE, t2.PARTY, t2.CONSTITUENCY, t2.VOTE_PERCENTAGE AS RUNNER_UP_VOTE_PERCENTAGE FROM $TABLE t2 JOIN (SELECT t.CODE, t.CONSTITUENCY, MAX(t.VOTES) AS RUNNER_VOTES FROM $TABLE t JOIN (SELECT a.CODE, a.CONSTITUENCY, MAX(a.VOTES) AS MAX_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) sub ON t.CODE = sub.CODE AND t.CONSTITUENCY = sub.CONSTITUENCY AND t.VOTES < sub.MAX_VOTES LEFT JOIN election_gates eg2 ON eg2.code = t.code AND eg2.status = 'EXCLUDE' WHERE t.STATE = '$display' AND eg2.code IS NULL GROUP BY t.CODE, t.CONSTITUENCY) sub2 ON t2.CODE = sub2.CODE AND t2.CONSTITUENCY = sub2.CONSTITUENCY AND t2.VOTES = sub2.RUNNER_VOTES LEFT JOIN election_gates eg3 ON eg3.code = t2.code AND eg3.status = 'EXCLUDE' WHERE t2.STATE = '$display' AND eg3.code IS NULL ORDER BY RUNNER_UP_VOTE_PERCENTAGE DESC" \
  "$dir/10 Max Vote share of a losing candidate.csv"

  # ── 11 LOST Deposits
  psql_csv \
  "SELECT DEPOSIT_LOSERS.PARTY, COUNT(DEPOSIT_LOSERS.PARTY) AS NO_OF_CANDIDATES_WITH_LESS_THAN_ONE_SIXTH_VOTES FROM (SELECT ger.CANDIDATE, ger.PARTY, ger.CONSTITUENCY, ger.VOTES, VOTE_DETAILS.TOTAL_VOTES, (ger.VOTES::numeric / NULLIF(VOTE_DETAILS.TOTAL_VOTES, 0)) AS VOTE_SHARE FROM (SELECT a.CODE, a.CONSTITUENCY, SUM(a.VOTES) AS TOTAL_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CODE, a.CONSTITUENCY) AS VOTE_DETAILS JOIN $TABLE ger ON VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY AND VOTE_DETAILS.CODE = ger.CODE LEFT JOIN election_gates eg2 ON eg2.code = ger.code AND eg2.status = 'EXCLUDE' WHERE ger.STATE = '$display' AND eg2.code IS NULL) DEPOSIT_LOSERS WHERE VOTE_SHARE < (1.0 / 6) AND PARTY <> 'NONE OF THE ABOVE' GROUP BY DEPOSIT_LOSERS.PARTY ORDER BY NO_OF_CANDIDATES_WITH_LESS_THAN_ONE_SIXTH_VOTES DESC" \
  "$dir/11 LOST Deposits.csv"

  # ── 12 All Parties
  psql_csv \
  "SELECT DISTINCT a.PARTY FROM $TABLE a $EG WHERE a.STATE = '$display' AND a.PARTY NOT IN ('INDEPENDENT', 'NOTA') $EG_WHERE ORDER BY a.PARTY" \
  "$dir/12 All Parties.csv"

  # ── 12 Gold
  psql_csv \
  "SELECT PARTY, COUNT(*) AS SEATS_WON FROM (SELECT a.CONSTITUENCY, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CONSTITUENCY ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) AS ranked_results WHERE rn = 1 GROUP BY PARTY ORDER BY SEATS_WON DESC" \
  "$dir/12 Gold.csv"

  # ── 13 Silver
  psql_csv \
  "SELECT PARTY, COUNT(*) AS SILVER_MEDALS FROM (SELECT a.CONSTITUENCY, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CONSTITUENCY ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) AS ranked_results WHERE rn = 2 GROUP BY PARTY ORDER BY SILVER_MEDALS DESC" \
  "$dir/13 Silver.csv"

  # ── 14 Cost per vote
  psql_csv \
  "SELECT PARTY, TOTAL_COST, PARTY_VOTES, (TOTAL_COST::numeric / NULLIF(PARTY_VOTES, 0)) AS COST_PER_VOTE FROM (SELECT (COUNT(ger.CANDIDATE) * 4000000) AS TOTAL_COST, GER.PARTY AS PARTY, PARTY_VOTE_DETAILS.PARTY_VOTES AS PARTY_VOTES FROM $TABLE GER JOIN (SELECT a.PARTY, SUM(a.VOTES) AS PARTY_VOTES FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.PARTY) AS PARTY_VOTE_DETAILS ON GER.PARTY = PARTY_VOTE_DETAILS.PARTY LEFT JOIN election_gates eg2 ON eg2.code = GER.code AND eg2.status = 'EXCLUDE' WHERE GER.STATE = '$display' AND eg2.code IS NULL GROUP BY GER.PARTY, PARTY_VOTE_DETAILS.PARTY_VOTES) COST_ANALYSIS ORDER BY COST_PER_VOTE ASC" \
  "$dir/14 Cost per vote.csv"

  # ── 14 Success Ratio
  psql_csv \
  "SELECT p.PARTY, p.SEATS_PARTICIPATED, w.SEATS_WON, (w.SEATS_WON::numeric / NULLIF(p.SEATS_PARTICIPATED, 0) * 100) AS SUCCESS_RATIO FROM (SELECT a.PARTY, COUNT(DISTINCT CONCAT(a.STATE, '_', a.CONSTITUENCY)) AS SEATS_PARTICIPATED FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.PARTY) p LEFT JOIN (SELECT PARTY, COUNT(*) AS SEATS_WON FROM (SELECT a.CONSTITUENCY, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CONSTITUENCY ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) ranked_results WHERE rn = 1 GROUP BY PARTY) w ON p.PARTY = w.PARTY ORDER BY SUCCESS_RATIO DESC, SEATS_PARTICIPATED DESC" \
  "$dir/14 Success Ratio.csv"

  # ── 15 Strike Rate - Worst (at least 1 Win)
  psql_csv \
  "SELECT p.PARTY, p.SEATS_PARTICIPATED, w.SEATS_WON, (w.SEATS_WON::numeric / NULLIF(p.SEATS_PARTICIPATED, 0) * 100) AS SUCCESS_RATIO FROM (SELECT a.PARTY, COUNT(DISTINCT CONCAT(a.STATE, '_', a.CONSTITUENCY)) AS SEATS_PARTICIPATED FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.PARTY) p LEFT JOIN (SELECT PARTY, COUNT(*) AS SEATS_WON FROM (SELECT a.CONSTITUENCY, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CONSTITUENCY ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) ranked_results WHERE rn = 1 GROUP BY PARTY) w ON p.PARTY = w.PARTY WHERE w.SEATS_WON >= 1 ORDER BY SUCCESS_RATIO ASC, SEATS_PARTICIPATED DESC" \
  "$dir/15 Strike Rate - Worst (At least 1 Win).csv"

  # ── 16 Multiple Participation
  psql_csv \
  "SELECT a.CANDIDATE, a.PARTY, COUNT(DISTINCT a.CODE) AS CONSTITUENCY_COUNT FROM $TABLE a $EG WHERE a.STATE = '$display' AND a.CANDIDATE <> 'NOTA' $EG_WHERE GROUP BY a.CANDIDATE, a.PARTY ORDER BY CONSTITUENCY_COUNT DESC, a.CANDIDATE" \
  "$dir/16 Multiple Participation.csv"

  # ── 17 Multiple Participation Results
  psql_csv \
  "WITH candidate_participation AS (SELECT a.CANDIDATE, a.PARTY, COUNT(DISTINCT CONCAT(a.STATE, '_', a.CODE)) AS CONSTITUENCY_COUNT FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE GROUP BY a.CANDIDATE, a.PARTY), ranked_results AS (SELECT a.CONSTITUENCY, a.CODE, a.CANDIDATE, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CODE ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE) SELECT r.CANDIDATE, r.CONSTITUENCY, r.CODE as CONSTITUENCY_CODE, r.PARTY, CASE WHEN r.rn = 1 THEN 'WON' ELSE 'LOST' END AS RESULT FROM ranked_results r JOIN candidate_participation cp ON r.CANDIDATE = cp.CANDIDATE AND r.PARTY = cp.PARTY WHERE cp.CONSTITUENCY_COUNT > 1 AND r.CANDIDATE <> 'NOTA' ORDER BY RESULT DESC, r.PARTY, r.CANDIDATE" \
  "$dir/17 Multiple Participation Results.csv"

  # ── 18 Close Contest Matrix
  psql_csv \
  "WITH ranked_results AS (SELECT a.CONSTITUENCY, a.CODE, a.CANDIDATE, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CODE ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE), winner_and_runner_up AS (SELECT r1.CONSTITUENCY, r1.CODE, r1.PARTY AS WINNING_PARTY, r1.VOTES AS WINNING_VOTES, r2.PARTY AS LOSING_PARTY, r2.VOTES AS LOSING_VOTES, (r1.VOTES - r2.VOTES) AS VOTE_DIFFERENCE FROM ranked_results r1 JOIN ranked_results r2 ON r1.CONSTITUENCY = r2.CONSTITUENCY AND r1.CODE = r2.CODE WHERE r1.rn = 1 AND r2.rn = 2) SELECT LOSING_PARTY, COUNT(CASE WHEN VOTE_DIFFERENCE < 500 THEN 1 END) AS \"< 500\", COUNT(CASE WHEN VOTE_DIFFERENCE < 2500 THEN 1 END) AS \"< 2500\", COUNT(CASE WHEN VOTE_DIFFERENCE < 5000 THEN 1 END) AS \"< 5000\", COUNT(CASE WHEN VOTE_DIFFERENCE < 10000 THEN 1 END) AS \"< 10000\", COUNT(CASE WHEN VOTE_DIFFERENCE < 15000 THEN 1 END) AS \"< 15000\", COUNT(CASE WHEN VOTE_DIFFERENCE < 25000 THEN 1 END) AS \"< 25000\", COUNT(CASE WHEN VOTE_DIFFERENCE < 50000 THEN 1 END) AS \"< 50000\" FROM winner_and_runner_up GROUP BY LOSING_PARTY HAVING COUNT(CASE WHEN VOTE_DIFFERENCE < 500 THEN 1 END) > 0 OR COUNT(CASE WHEN VOTE_DIFFERENCE < 2500 THEN 1 END) > 0 OR COUNT(CASE WHEN VOTE_DIFFERENCE < 5000 THEN 1 END) > 0 OR COUNT(CASE WHEN VOTE_DIFFERENCE < 10000 THEN 1 END) > 0 OR COUNT(CASE WHEN VOTE_DIFFERENCE < 15000 THEN 1 END) > 0 OR COUNT(CASE WHEN VOTE_DIFFERENCE < 25000 THEN 1 END) > 0 OR COUNT(CASE WHEN VOTE_DIFFERENCE < 50000 THEN 1 END) > 0 ORDER BY LOSING_PARTY" \
  "$dir/18 Close Contest Matrix.csv"

  # ── 19 Party Specific (top 4 by seats won) ────────────────────────
  if [ -f "$dir/12 Gold.csv" ]; then
    local party_count=0
    while IFS=, read -r party seats; do
      party=$(echo "$party" | tr -d '"' | tr -d '\r')
      [ -z "$party" ] && continue
      party_count=$((party_count + 1))
      if [ "$party_count" -gt 4 ]; then break; fi
      local safe_party
      safe_party=$(echo "$party" | tr '/' '_' | sed "s/'/''/g")
      psql_csv \
      "WITH ranked_results AS (SELECT a.CONSTITUENCY, a.CODE, a.CANDIDATE, a.PARTY, a.VOTES, ROW_NUMBER() OVER (PARTITION BY a.CODE ORDER BY a.VOTES DESC) AS rn FROM $TABLE a $EG WHERE a.STATE = '$display' $EG_WHERE), winner_and_runner_up AS (SELECT r1.CONSTITUENCY, r1.CODE, r1.PARTY AS WINNING_PARTY, r1.VOTES AS WINNING_VOTES, r2.PARTY AS RUNNER_UP_PARTY, r2.VOTES AS RUNNER_UP_VOTES FROM ranked_results r1 JOIN ranked_results r2 ON r1.CONSTITUENCY = r2.CONSTITUENCY AND r1.CODE = r2.CODE WHERE r1.rn = 1 AND r2.rn = 2) SELECT CONSTITUENCY, CODE AS CONSTITUENCY_CODE, RUNNER_UP_VOTES, WINNING_PARTY, WINNING_VOTES, (WINNING_VOTES - RUNNER_UP_VOTES) AS VOTE_DIFFERENCE FROM winner_and_runner_up WHERE RUNNER_UP_PARTY = '$safe_party' AND (WINNING_VOTES - RUNNER_UP_VOTES) < 50000 ORDER BY VOTE_DIFFERENCE ASC" \
      "$dir/19 Party Specific - $party.csv"
    done < <(tail -n +2 "$dir/12 Gold.csv")
  fi

  # ── 22 Crowding Pressure Seats
  psql_csv \
  "WITH candidate_counts AS (SELECT a.code, a.constituency, COUNT(*) AS candidate_count FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE GROUP BY a.code, a.constituency), ranked AS (SELECT a.code, a.constituency, a.party, a.votes, a.vote_percentage, a.postal_votes, ROW_NUMBER() OVER (PARTITION BY a.code ORDER BY a.votes DESC) AS rn FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE), others AS (SELECT code, constituency, SUM(vote_percentage) AS others_pct FROM ranked WHERE rn >= 3 GROUP BY code, constituency), margins AS (SELECT w.code, w.constituency, w.party AS winning_party, r.party AS runner_up_party, w.votes - r.votes AS margin_votes, w.vote_percentage - r.vote_percentage AS margin_pct, w.postal_votes - r.postal_votes AS postal_gap FROM ranked w JOIN ranked r ON w.code = r.code AND w.constituency = r.constituency AND r.rn = 2 WHERE w.rn = 1) SELECT m.code AS constituency_code, m.constituency, m.winning_party, m.runner_up_party, c.candidate_count, ROUND(o.others_pct, 2) AS others_vote_pct, m.margin_votes, ROUND(m.margin_pct, 2) AS margin_pct, m.postal_gap, CASE WHEN c.candidate_count >= 15 THEN 'Ultra-crowded' WHEN c.candidate_count BETWEEN 10 AND 14 THEN 'Crowded' ELSE 'Standard' END AS crowding_band FROM margins m JOIN candidate_counts c ON c.code = m.code AND c.constituency = m.constituency JOIN others o ON o.code = m.code AND o.constituency = m.constituency WHERE m.margin_votes < 10000 ORDER BY o.others_pct DESC LIMIT 15" \
  "$dir/22 Crowding Pressure Seats.csv"

  # ── 23 Runner Up Overperformance
  psql_csv \
  "WITH party_totals AS (SELECT a.party, COUNT(*) AS contests, AVG(a.vote_percentage) AS avg_pct FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE GROUP BY a.party), ranked AS (SELECT a.constituency, a.candidate, a.party, a.vote_percentage, a.votes, ROW_NUMBER() OVER (PARTITION BY a.code ORDER BY a.votes DESC) AS rn FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE) SELECT r.constituency, r.candidate, r.party, ROUND(r.vote_percentage, 2) AS runner_up_vote_pct, ROUND(pt.avg_pct, 2) AS party_avg_vote_pct, ROUND(r.vote_percentage - pt.avg_pct, 2) AS overperformance_pct, pt.contests AS total_constested_at FROM ranked r JOIN party_totals pt ON pt.party = r.party WHERE r.rn = 2 AND pt.contests >= 5 ORDER BY overperformance_pct DESC LIMIT 15" \
  "$dir/23 Runner Up Overperformance.csv"

  # ── 24 HHI Win Mix
  psql_csv \
  "WITH shares AS (SELECT a.code, a.constituency, SUM(a.vote_percentage) AS total_pct FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE GROUP BY a.code, a.constituency), hhi AS (SELECT b.code, b.constituency, SUM(POWER(b.vote_percentage / NULLIF(s.total_pct, 0), 2)) AS hhi FROM $TABLE b JOIN shares s ON s.code = b.code AND s.constituency = b.constituency LEFT JOIN election_gates eg2 ON eg2.code = b.code AND eg2.status = 'EXCLUDE' WHERE b.state = '$display' AND eg2.code IS NULL GROUP BY b.code, b.constituency), hhi_bands AS (SELECT code, constituency, hhi, CASE WHEN hhi < 0.35 THEN 'Fragmented' WHEN hhi BETWEEN 0.35 AND 0.45 THEN 'Competitive' ELSE 'Dominant' END AS hhi_band FROM hhi), ranked AS (SELECT a.code, a.constituency, a.party, ROW_NUMBER() OVER (PARTITION BY a.code ORDER BY a.votes DESC) AS rn FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE) SELECT r.party, hb.hhi_band, COUNT(*) AS seats_won FROM ranked r JOIN hhi_bands hb ON hb.code = r.code AND hb.constituency = r.constituency WHERE r.rn = 1 GROUP BY r.party, hb.hhi_band ORDER BY r.party, hb.hhi_band" \
  "$dir/24 HHI Win Mix.csv"

  # ── 25 Third Place Spoilers
  psql_csv \
  "WITH ranked AS (SELECT a.code, a.constituency, a.party, a.candidate, a.vote_percentage, a.votes, ROW_NUMBER() OVER (PARTITION BY a.code ORDER BY a.votes DESC) AS rn FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE), third_place AS (SELECT code, constituency, party, candidate, vote_percentage, votes FROM ranked WHERE rn = 3), party_totals AS (SELECT a.party, COUNT(*) AS contests, AVG(a.vote_percentage) AS avg_pct FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE GROUP BY a.party), candidate_counts AS (SELECT a.code, a.constituency, COUNT(*) AS total_candidates FROM $TABLE a $EG WHERE a.state = '$display' $EG_WHERE GROUP BY a.code, a.constituency), close_margins AS (SELECT w.code, w.constituency, w.votes - r.votes AS margin_votes FROM ranked w JOIN ranked r ON r.code = w.code AND r.constituency = w.constituency AND r.rn = 2 WHERE w.rn = 1) SELECT t.code AS constituency_code, t.constituency, t.party, t.candidate, ROUND(t.vote_percentage, 2) AS third_place_vote_pct, ROUND(pt.avg_pct, 2) AS party_avg_vote_pct, ROUND(t.vote_percentage - pt.avg_pct, 2) AS overperformance_pct, cc.total_candidates, cm.margin_votes FROM third_place t JOIN party_totals pt ON pt.party = t.party JOIN candidate_counts cc ON cc.code = t.code AND cc.constituency = t.constituency JOIN close_margins cm ON cm.code = t.code AND cm.constituency = t.constituency WHERE pt.contests >= 5 AND cm.margin_votes < 10000 ORDER BY overperformance_pct DESC LIMIT 15" \
  "$dir/25 Third Place Spoilers.csv"

  echo "  Done: $display"
}

# ── Main ─────────────────────────────────────────────────────────────────
echo "Running election queries..."

# Verify database connectivity
if ! psql "$PSQL_CONN" -c "SELECT 1" &>/dev/null; then
  echo "ERROR: Cannot connect to PostgreSQL with: psql $PSQL_CONN"
  echo "Set PSQL_CONN environment variable to override."
  exit 1
fi
echo "Database connection OK"

# Verify election_gates table exists
if ! psql "$PSQL_CONN" -c "SELECT 1 FROM election_gates LIMIT 1" &>/dev/null; then
  echo "ERROR: election_gates table not found. Run queries/Queries.sql first."
  exit 1
fi
echo "Election gates table OK"

if [ -n "$TARGET_STATE" ]; then
  idx=$(state_index "$TARGET_STATE")
  if [ "$idx" -eq -1 ]; then
    echo "ERROR: State '$TARGET_STATE' not found in STATES array"
    echo "Valid states: ${STATES[*]}"
    exit 1
  fi
  run_queries_for_state "$idx"
else
  for idx in "${!STATES[@]}"; do
    run_queries_for_state "$idx"
  done
fi

echo "All queries complete."
