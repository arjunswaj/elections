-- Classify each constituency by Herfindahl-Hirschman Index (HHI) and count seats won by party across competition bands
WITH shares AS
  (SELECT state,
          code,
          constituency,
          SUM(vote_percentage) AS total_pct
   FROM public.assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL
   GROUP BY state,
            code,
            constituency),
     hhi AS
  (SELECT a.state,
          a.code,
          a.constituency,
          SUM(POWER(vote_percentage / NULLIF(s.total_pct, 0), 2)) AS hhi
   FROM public.assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   JOIN shares s ON s.state = a.state
   AND s.code = a.code
   AND s.constituency = a.constituency
   WHERE eg.code IS NULL
   GROUP BY a.state,
            a.code,
            a.constituency),
     hhi_bands AS
  (SELECT state,
          code,
          constituency,
          hhi,
          CASE
              WHEN hhi < 0.35 THEN 'Fragmented'
              WHEN hhi BETWEEN 0.35 AND 0.45 THEN 'Competitive'
              ELSE 'Dominant'
          END AS hhi_band
   FROM hhi),
     ranked AS
  (SELECT state,
          code,
          constituency,
          party,
          ROW_NUMBER() OVER (PARTITION BY state, code
                             ORDER BY votes DESC) AS rn
   FROM public.assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL)
SELECT r.party,
       hb.hhi_band,
       COUNT(*) AS seats_won
FROM ranked r
JOIN hhi_bands hb ON hb.state = r.state
AND hb.code = r.code
AND hb.constituency = r.constituency
WHERE r.rn = 1
GROUP BY r.party,
         hb.hhi_band
ORDER BY r.party,
         hb.hhi_band;
