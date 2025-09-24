-- Classify each constituency by Herfindahl-Hirschman Index (HHI) and count seats won by party across competition bands
WITH shares AS (
    SELECT constituency,
           SUM(vote_percentage) AS total_pct
    FROM public.assembly_elections_feb2025
    GROUP BY constituency
), hhi AS (
    SELECT a.constituency,
           SUM(POWER(vote_percentage / s.total_pct, 2)) AS hhi
    FROM public.assembly_elections_feb2025 a
    JOIN shares s ON s.constituency = a.constituency
    GROUP BY a.constituency
), hhi_bands AS (
    SELECT constituency,
           hhi,
           CASE
               WHEN hhi < 0.35 THEN 'Fragmented'
               WHEN hhi BETWEEN 0.35 AND 0.45 THEN 'Competitive'
               ELSE 'Dominant'
           END AS hhi_band
    FROM hhi
), ranked AS (
    SELECT constituency,
           party,
           ROW_NUMBER() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rn
    FROM public.assembly_elections_feb2025
)
SELECT r.party,
       hb.hhi_band,
       COUNT(*) AS seats_won
FROM ranked r
JOIN hhi_bands hb ON hb.constituency = r.constituency
WHERE r.rn = 1
GROUP BY r.party, hb.hhi_band
ORDER BY r.party, hb.hhi_band;
