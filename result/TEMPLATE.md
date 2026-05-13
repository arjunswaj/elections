# Table of contents

- [Analysis of {{STATE_DISPLAY}} Assembly Elections {{MONTH}}](#analysis-of-{{state_display}}-assembly-elections-{{month}})
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
{{PARTY_TOC_ENTRIES}}
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of {{STATE_DISPLAY}} Assembly Elections {{MONTH}}

The {{YEAR}} {{STATE_DISPLAY}} Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting and results declared by the Election Commission of India.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/{{STATE}}).

## Analysis
A total of {{TOTAL_CANDIDATES}} candidates contested in the {{STATE_DISPLAY}} assembly elections and about {{VOTES_CRORE}} Crore (`{{TOTAL_VOTES}}`) votes were cast during this period. Excluding Independents and NOTA, {{REGISTERED_PARTIES}} registered parties featured on the ballot—from the big alliances.

### Seats contested by Parties

{{TABLE:01 Number Of Candidates.csv:10:top}}

### Max and Mins

#### Maximum votes for a candidate

{{TABLE:02 Maximum Votes for a Candidate.csv:5:top}}

#### Least votes for a winning candidate

{{TABLE:03 Least votes for a winning candidate.csv:5:top}}

#### Max votes for a losing candidate

{{TABLE:04 Max votes for a losing candidate.csv:5:top}}

#### Candidates winning by Max margin (Unilateral winner)

{{TABLE:05 Candidates winning by Max or Min margin.csv:5:top}}

#### Candidates winning by Least margin (Fierce battle)

{{TABLE:05 Candidates winning by Max or Min margin.csv:5:bottom}}

### Max and Mins - Constituencies
#### Max Total Votes in a Constituency

{{TABLE:06 Max Total Votes in Constituency.csv:5:top}}

#### Min Total Votes Constituency

{{TABLE:06 Max Total Votes in Constituency.csv:5:bottom}}

#### Max candidates in a Constituency

{{TABLE:07 Max Candidates in a Constituency.csv:5:top}}

#### Least candidates in a Constituency

{{TABLE:07 Max Candidates in a Constituency.csv:5:bottom}}

### Vote Shares

#### Total Vote Share of Parties

{{TABLE:08 Total Vote Share.csv:5:top}}

#### Maximum Vote share for a winning candidate

{{TABLE:09 Least Vote share of Winning Candidate.csv:5:bottom}}

#### Least Vote share for a winning candidate

{{TABLE:09 Least Vote share of Winning Candidate.csv:5:top}}

#### Max Vote share of a losing candidate

{{TABLE:10 Max Vote share of a losing candidate.csv:5:top}}

#### Seats in which Parties lost deposits (less than 1/6 vote share)

{{TABLE:11 LOST Deposits.csv:5:top}}

### Medals

#### Gold (Seats that Parties won)

{{TABLE:12 Gold.csv:5:top}}

#### Silver (Seats that Parties came in second)

{{TABLE:13 Silver.csv:5:top}}

### Strike Rates

#### Cost per vote - Best Value per vote

{{TABLE:14 Cost per vote.csv:5:top}}

#### Cost per vote - Worst Value per vote

{{TABLE:14 Cost per vote.csv:5:bottom}}

#### Success Ratio

{{TABLE_SUCCESS:14 Success Ratio.csv:5:bottom}}

#### Success Ratio - Worst (At least 1 Win)

{{TABLE:15 Strike Rate - Worst (At least 1 Win).csv:5:top}}

### Multiple Seat Participation

#### Candidates participating in multiple seats (matches names)

{{TABLE:16 Multiple Participation.csv:10:top}}

#### Results of Candidates participating in multiple seats

{{TABLE:17 Multiple Participation Results.csv:10:top}}

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

{{TABLE:18 Close Contest Matrix.csv:10:top}}

#### Party Specific Close Contest Matrix

{{PARTY_SPECIFIC_SECTIONS}}

### Advanced Join Insights

The following highlights rely on multi-layer joins that combine margin, vote-share distribution, and competition intensity. Full result sets are saved in `result/{{STATE}}/22 Crowding Pressure Seats.csv`, `result/{{STATE}}/23 Runner Up Overperformance.csv`, `result/{{STATE}}/24 HHI Win Mix.csv`, and `result/{{STATE}}/25 Third Place Spoilers.csv`.

#### Crowding pressure seats

Seats where narrow margins collide with double-digit "others" vote share signal the highest volatility. Postal vote gaps are included to show where mailed ballots could tip the balance.

{{TABLE:22 Crowding Pressure Seats.csv:5:top}}

#### Runner-up overperformance vs party baseline

Comparing runner-up vote share with each party's average reveals hidden pockets of strength despite losses.

{{TABLE:23 Runner Up Overperformance.csv:5:top}}

#### HHI win mix by party

HHI bands group constituencies by vote concentration, illustrating which parties thrive in dominant versus competitive environments.

{{TABLE:24 HHI Win Mix.csv:10:top}}

#### Third-place spoilers in tight races

Third-place performers who beat their party's customary share often decide the margins in knife-edge seats.

{{TABLE:25 Third Place Spoilers.csv:5:top}}
