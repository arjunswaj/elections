-- Identify constituencies with narrow margins where many candidates and "others" vote share could swing the result
WITH candidate_counts AS (
    SELECT constituency,
           COUNT(*) AS candidate_count
    FROM public.assembly_elections_feb2025
    GROUP BY constituency
), ranked AS (
    SELECT constituency,
           party,
           votes,
           vote_percentage,
           postal_votes,
           ROW_NUMBER() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rn
    FROM public.assembly_elections_feb2025
), others AS (
    SELECT constituency,
           SUM(vote_percentage) AS others_pct
    FROM ranked
    WHERE rn >= 3
    GROUP BY constituency
), margins AS (
    SELECT w.constituency,
           w.party AS winning_party,
           r.party AS runner_up_party,
           w.votes - r.votes AS margin_votes,
           w.vote_percentage - r.vote_percentage AS margin_pct,
           w.postal_votes - r.postal_votes AS postal_gap
    FROM ranked w
    JOIN ranked r
      ON w.constituency = r.constituency
     AND r.rn = 2
    WHERE w.rn = 1
)
SELECT m.constituency,
       m.winning_party,
       m.runner_up_party,
       c.candidate_count,
       ROUND(o.others_pct, 2) AS others_vote_pct,
       m.margin_votes,
       ROUND(m.margin_pct, 2) AS margin_pct,
       m.postal_gap,
       CASE
           WHEN c.candidate_count >= 15 THEN 'Ultra-crowded'
           WHEN c.candidate_count BETWEEN 10 AND 14 THEN 'Crowded'
           ELSE 'Standard'
       END AS crowding_band
FROM margins m
JOIN candidate_counts c ON c.constituency = m.constituency
JOIN others o ON o.constituency = m.constituency
WHERE m.margin_votes < 10000
ORDER BY o.others_pct DESC
LIMIT 15;
