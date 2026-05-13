# Table of contents

- [Analysis of {{STATE_DISPLAY}} Assembly Elections {{MONTH}}](#analysis-of-{{state_display}}-assembly-elections-{{month}})
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
{{PARTY_TOC_ENTRIES}}
+ [Advanced Join Insights](#advanced-join-insights)
- [Crowding pressure seats](#crowding-pressure-seats)
- [Runner-up overperformance vs party baseline](#runner-up-overperformance-vs-party-baseline)
- [HHI win mix by party](#hhi-win-mix-by-party)
- [Third-place spoilers in tight races](#third-place-spoilers-in-tight-races)

# Analysis of {{STATE_DISPLAY}} Assembly Elections {{MONTH}}

The {{YEAR}} {{STATE_DISPLAY}} Legislative Assembly elections were conducted to elect members of the Vidhan Sabha, with counting overseen by the Election Commission of India soon after polling.

This page provides the highlights of the results. Complete results of the analysis can be seen [here](https://github.com/arjunswaj/elections/tree/2026-election/result/{{STATE}}).

## Analysis
A total of {{TOTAL_CANDIDATES}} candidates contested in the {{STATE_DISPLAY}} assembly elections and about {{VOTES_CRORE}} Crore (`{{TOTAL_VOTES}}`) votes were cast during this period.

### Seats contested by Parties

{{BAR_CHART:01 Number Of Candidates.csv:10:top:Party:Number of Seats}}

### Max and Mins

#### Maximum votes for a candidate

{{BAR_CHART:02 Maximum Votes for a Candidate.csv:5:top:Candidate (Party, Constituency):Number of Votes}}

#### Least votes for a winning candidate

{{BAR_CHART:03 Least votes for a winning candidate.csv:5:top:Candidate (Party, Constituency):Number of Votes}}

#### Max votes for a losing candidate

{{BAR_CHART:04 Max votes for a losing candidate.csv:5:top:Candidate (Party, Constituency):Number of Votes}}

#### Candidates winning by Max margin (Unilateral winner)

{{BAR_CHART:05 Candidates winning by Max or Min margin.csv:5:top:Winner (Party, Constituency):Vote Difference}}

#### Candidates winning by Least margin (Fierce battle)

{{BAR_CHART:05 Candidates winning by Max or Min margin.csv:5:bottom:Winner (Party, Constituency):Vote Difference}}

#### Max Total Votes in a Constituency

{{BAR_CHART:06 Max Total Votes in Constituency.csv:5:top:Constituency (State):Total Votes}}

#### Min Total Votes Constituency

{{BAR_CHART:06 Max Total Votes in Constituency.csv:5:bottom:Constituency (State):Total Votes}}

#### Max Candidates in a Constituency

{{BAR_CHART:07 Max Candidates in a Constituency.csv:5:top:Constituency (State):Number of Candidates}}

#### Least Candidates in a Constituency

{{BAR_CHART:07 Max Candidates in a Constituency.csv:5:bottom:Constituency (State):Number of Candidates}}

#### Total Vote Share of Parties

{{PIE_CHART:08 Total Vote Share.csv:5:top}}

#### Maximum Vote Share of Winning Candidate

{{BAR_CHART:09 Least Vote share of Winning Candidate.csv:5:bottom:Candidate (Party, Constituency):Vote Share}}

#### Least Vote Share for a Winning Candidate

{{BAR_CHART:09 Least Vote share of Winning Candidate.csv:5:top:Candidate (Party, Constituency):Vote Share}}

#### Max Vote Share of a Losing Candidate

{{BAR_CHART:10 Max Vote share of a losing candidate.csv:5:top:Candidate (Party, Constituency):Vote Share}}

#### Seats in which Parties Lost Deposits (less than 1/6 vote share)

{{BAR_CHART:11 LOST Deposits.csv:5:top:Party:Number of Seats}}

#### Gold (Seats that Parties Won)

{{BAR_CHART:12 Gold.csv:5:top:Party:Number of Seats}}

#### Silver (Seats that Parties Came in Second)

{{BAR_CHART:13 Silver.csv:5:top:Party:Number of Seats}}

#### Cost per Vote - Best Value

{{BAR_CHART:14 Cost per vote.csv:5:top:Party:Cost per Vote}}

#### Cost per Vote - Worst Value

{{BAR_CHART:14 Cost per vote.csv:5:bottom:Party:Cost per Vote}}

#### Success Ratio - Best

{{TABLE_SUCCESS:14 Success Ratio.csv:5:bottom}}

#### Success Ratio - Worst

{{TABLE:15 Strike Rate - Worst (At least 1 Win).csv:5:top}}

### Multiple Seat Participation

#### Results of Candidates participating in multiple seats

{{TABLE:17 Multiple Participation Results.csv:10:top}}

### Close Contest Matrix
This matrix provides the number of seats in which parties lost by the number of votes provided in the columns.

{{TABLE:18 Close Contest Matrix.csv:10:top}}

#### Party Specific Close Contest Matrix

{{PARTY_SPECIFIC_SECTIONS}}

### Advanced Join Insights

#### Crowding pressure seats

Crowded ballots with thin margins are visualized below using "others" vote share as a proxy for fragmentation.

{{TABLE:22 Crowding Pressure Seats.csv:5:top}}

{{BAR_CHART:22 Crowding Pressure Seats.csv:5:top:Constituency:Others Vote %}}

#### Runner-up overperformance vs party baseline

These runner-up candidates beat their party-wide average vote share even in defeat.

{{TABLE:23 Runner Up Overperformance.csv:5:top}}

{{BAR_CHART:23 Runner Up Overperformance.csv:5:top:Constituency:Overperformance %}}

#### HHI win mix by party

Competition bands (Herfindahl-Hirschman Index) show which parties dominate different contest types.

{{TABLE:24 HHI Win Mix.csv:10:top}}

{{STACKED_BAR_CHART:24 HHI Win Mix.csv}}

#### Third-place spoilers in tight races

Third-place candidacies that materially exceeded their party's norm highlight potential spoiler roles.

{{BAR_CHART:25 Third Place Spoilers.csv:5:top:Constituency:Overperformance %}}
