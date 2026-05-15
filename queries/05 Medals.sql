-- All Parties

SELECT DISTINCT PARTY
FROM assembly_elections_may2026 a
LEFT JOIN election_gates eg ON eg.code = a.code
AND eg.status = 'EXCLUDE'
WHERE eg.code IS NULL
  AND PARTY NOT IN ('INDEPENDENT',
                    'NOTA')
ORDER BY PARTY;

-- Gold Medals

SELECT STATE,
       PARTY,
       COUNT(*) AS SEATS_WON
FROM
  (SELECT STATE,
          CONSTITUENCY,
          PARTY,
          VOTES,
          ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY
                             ORDER BY VOTES DESC) AS rn
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL) AS ranked_results
WHERE rn = 1
GROUP BY STATE,
         PARTY
ORDER BY STATE ASC,
         SEATS_WON DESC;

-- Silver Medals

SELECT STATE,
       PARTY,
       COUNT(*) AS SILVER_MEDALS
FROM
  (SELECT STATE,
          CONSTITUENCY,
          PARTY,
          VOTES,
          ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY
                             ORDER BY VOTES DESC) AS rn
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL) AS ranked_results
WHERE rn = 2
GROUP BY STATE,
         PARTY
ORDER BY STATE ASC,
         SILVER_MEDALS DESC;
