-- Multiple seats participating candidates

SELECT STATE,
       CANDIDATE,
       COUNT(DISTINCT CODE) AS CONSTITUENCY_COUNT
FROM assembly_elections_may2026 a
LEFT JOIN election_gates eg ON eg.code = a.code
AND eg.status = 'EXCLUDE'
WHERE eg.code IS NULL
  AND CANDIDATE <> 'NOTA'
GROUP BY STATE,
         CANDIDATE,
         PARTY
ORDER BY STATE ASC,
         CONSTITUENCY_COUNT DESC,
         CANDIDATE;

-- Multiple participation results
WITH candidate_participation AS
  (SELECT STATE,
          CANDIDATE,
          PARTY,
          COUNT(DISTINCT CONCAT(STATE, '_', CODE)) AS CONSTITUENCY_COUNT
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL
   GROUP BY STATE,
            CANDIDATE,
            PARTY),
     ranked_results AS
  (SELECT STATE,
          CONSTITUENCY,
          CODE,
          CANDIDATE,
          PARTY,
          VOTES,
          ROW_NUMBER() OVER (PARTITION BY STATE, CODE
                             ORDER BY VOTES DESC) AS rn
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL)
SELECT r.STATE,
       r.CANDIDATE,
       r.CONSTITUENCY,
       r.CODE AS CONSTITUENCY_CODE,
       r.PARTY,
       CASE
           WHEN r.rn = 1 THEN 'WON'
           ELSE 'LOST'
       END AS RESULT
FROM ranked_results r
JOIN candidate_participation cp ON r.STATE = cp.STATE
AND r.CANDIDATE = cp.CANDIDATE
AND r.PARTY = cp.PARTY
WHERE cp.CONSTITUENCY_COUNT > 1
  AND r.CANDIDATE <> 'NOTA'
ORDER BY r.STATE ASC,
         RESULT DESC, r.PARTY,
                      r.CANDIDATE;
