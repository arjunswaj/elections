-- Highlight runner-up candidates who materially exceeded their party's average vote share
WITH party_totals AS (
    SELECT party,
           COUNT(*) AS contests,
           AVG(vote_percentage) AS avg_pct
  FROM public.assembly_elections_may2026
    GROUP BY party
), ranked AS (
    SELECT constituency,
           candidate,
           party,
           vote_percentage,
           votes,
           ROW_NUMBER() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rn
  FROM public.assembly_elections_may2026
)
SELECT r.constituency,
       r.candidate,
       r.party,
       ROUND(r.vote_percentage, 2) AS runner_up_vote_pct,
       ROUND(pt.avg_pct, 2) AS party_avg_vote_pct,
       ROUND(r.vote_percentage - pt.avg_pct, 2) AS overperformance_pct,
       pt.contests AS total_constituencies_contested
FROM ranked r
JOIN party_totals pt ON pt.party = r.party
WHERE r.rn = 2
  AND pt.contests >= 5
ORDER BY overperformance_pct DESC
LIMIT 15;
