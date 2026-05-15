-- Surface third-place candidates whose vote share exceeded their party's average in seats with tight winning margins
WITH ranked AS 
  (SELECT state, 
          code, 
          constituency, 
          party, 
          candidate, 
          vote_percentage, 
          votes, 
          ROW_NUMBER() OVER (PARTITION BY state, code
                             ORDER BY votes DESC) AS rn
   FROM public.assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE' 
   WHERE eg.code IS NULL), 
     third_place AS 
  (SELECT state, 
          code, 
          constituency, 
          party, 
          candidate, 
          vote_percentage, 
          votes
   FROM ranked 
   WHERE rn = 3), 
     party_totals AS 
  (SELECT party, 
          COUNT(*) AS contests, 
          AVG(vote_percentage) AS avg_pct
   FROM public.assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE' 
   WHERE eg.code IS NULL 
   GROUP BY party), 
     candidate_counts AS 
  (SELECT state, 
          code, 
          constituency, 
          COUNT(*) AS total_candidates
   FROM public.assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL
   GROUP BY state,
            code,
            constituency),
     close_margins AS
  (SELECT w.state,
          w.code,
          w.constituency,
          w.votes - r.votes AS margin_votes
   FROM ranked w
   JOIN ranked r ON r.state = w.state
   AND r.code = w.code
   AND r.constituency = w.constituency
   AND r.rn = 2
   WHERE w.rn = 1)
SELECT t.state,
       t.code AS constituency_code,
       t.constituency,
       t.party,
       t.candidate,
       ROUND(t.vote_percentage, 2) AS third_place_vote_pct,
       ROUND(pt.avg_pct, 2) AS party_avg_vote_pct,
       ROUND(t.vote_percentage - pt.avg_pct, 2) AS overperformance_pct,
       cc.total_candidates,
       cm.margin_votes
FROM third_place t
JOIN party_totals pt ON pt.party = t.party
JOIN candidate_counts cc ON cc.state = t.state
AND cc.code = t.code
AND cc.constituency = t.constituency
JOIN close_margins cm ON cm.state = t.state
AND cm.code = t.code
AND cm.constituency = t.constituency
WHERE pt.contests >= 5
  AND cm.margin_votes < 10000
ORDER BY overperformance_pct DESC
LIMIT 15;
