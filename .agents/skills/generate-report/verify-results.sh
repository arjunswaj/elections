#!/usr/bin/env bash
# verify-results.sh — Pre-flight checks before running generate.sh
# Usage: bash .agents/skills/process-results/verify-results.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../../" && pwd)"
RESULT_DIR="$REPO_ROOT/result"
GENERATE_SH="$RESULT_DIR/generate.sh"

echo "=== Verifying election results data ==="

# Check generate.sh exists
if [ ! -f "$GENERATE_SH" ]; then
  echo "FAIL: generate.sh not found at $GENERATE_SH"
  exit 1
fi
echo "OK: generate.sh found"

# Check bc is available
if ! command -v bc &>/dev/null; then
  echo "FAIL: 'bc' is required but not installed"
  exit 1
fi
echo "OK: bc available"

# Extract STATES array from generate.sh
STATES=()
eval "$(grep '^STATES=' "$GENERATE_SH" | head -1)"
echo "OK: States configured: ${STATES[*]}"

# Check each state directory exists
EXPECTED_CSVS=(
  "01 Number Of Candidates by State.csv"
  "01 Number Of Candidates.csv"
  "01 Number Of Votes.csv"
  "02 Maximum Votes for a Candidate.csv"
  "03 Least votes for a winning candidate.csv"
  "04 Max votes for a losing candidate.csv"
  "05 Candidates winning by Max or Min margin.csv"
  "06 Max Total Votes in Constituency.csv"
  "07 Max Candidates in a Constituency.csv"
  "08 Total Vote Share.csv"
  "09 Least Vote share of Winning Candidate.csv"
  "10 Max Vote share of a losing candidate.csv"
  "11 LOST Deposits.csv"
  "12 All Parties.csv"
  "12 Gold.csv"
  "13 Silver.csv"
  "14 Cost per vote.csv"
  "14 Success Ratio.csv"
  "15 Strike Rate - Worst (At least 1 Win).csv"
  "16 Multiple Participation.csv"
  "17 Multiple Participation Results.csv"
  "18 Close Contest Matrix.csv"
  "22 Crowding Pressure Seats.csv"
  "23 Runner Up Overperformance.csv"
  "24 HHI Win Mix.csv"
  "25 Third Place Spoilers.csv"
)

errors=0
for state in "${STATES[@]}"; do
  state_dir="$RESULT_DIR/$state"
  if [ ! -d "$state_dir" ]; then
    echo "FAIL: State directory missing: $state_dir"
    errors=$((errors + 1))
    continue
  fi

  missing=0
  for csv in "${EXPECTED_CSVS[@]}"; do
    if [ ! -f "$state_dir/$csv" ]; then
      echo "  MISSING: $state/$csv"
      missing=$((missing + 1))
    fi
  done

  # Check for at least one Party Specific CSV
  party_csvs=$(ls "$state_dir"/19\ Party\ Specific\ -\ *.csv 2>/dev/null | wc -l)
  if [ "$party_csvs" -eq 0 ]; then
    echo "  MISSING: $state/19 Party Specific - *.csv (none found)"
    missing=$((missing + 1))
  fi

  if [ "$missing" -eq 0 ]; then
    total_csvs=$(ls "$state_dir"/*.csv 2>/dev/null | wc -l)
    echo "OK: $state — all expected CSVs present ($total_csvs total)"
  else
    echo "FAIL: $state — $missing CSVs missing"
    errors=$((errors + 1))
  fi
done

# Check for legacy root-level STATE.md files
legacy_files=$(ls "$REPO_ROOT"/BIHAR*.md "$REPO_ROOT"/NEWDELHI*.md "$REPO_ROOT"/ASSAM*.md "$REPO_ROOT"/KERALA*.md "$REPO_ROOT"/PUDUCHERRY*.md "$REPO_ROOT"/*BENGAL*.md "$REPO_ROOT"/*NADU*.md 2>/dev/null || true)
if [ -n "$legacy_files" ]; then
  echo ""
  echo "WARNING: Legacy markdown files found in repo root (should be deleted):"
  echo "$legacy_files"
fi

# Check TOC anchor generation (display_anchor pattern)
echo ""
echo "=== Checking TOC anchor pattern in generate.sh ==="
if grep -q 'display_anchor' "$GENERATE_SH"; then
  echo "OK: display_anchor variable used (hyphens in TOC links)"
else
  echo "FAIL: display_anchor not found — TOC links for multi-word states may have spaces"
  errors=$((errors + 1))
fi

# Check shorten_party ordering (AIADMK before DMK)
echo ""
echo "=== Checking shorten_party sed ordering ==="
aiadmk_line=$(grep -n 'All India Anna Dravida Munnetra Kazhagam' "$GENERATE_SH" | head -1 | cut -d: -f1)
dmk_line=$(grep -n 's/Dravida Munnetra Kazhagam/DMK' "$GENERATE_SH" | head -1 | cut -d: -f1)
if [ -n "$aiadmk_line" ] && [ -n "$dmk_line" ] && [ "$aiadmk_line" -lt "$dmk_line" ]; then
  echo "OK: AIADMK rule comes before DMK rule"
else
  echo "FAIL: AIADMK rule must come before DMK rule in shorten_party (longer match first)"
  errors=$((errors + 1))
fi

echo ""
if [ "$errors" -eq 0 ]; then
  echo "=== All checks passed. Ready to run: bash result/generate.sh ==="
  exit 0
else
  echo "=== $errors check(s) failed. Fix before generating. ==="
  exit 1
fi
