-- Max Total Votes in a Constituency
-- Constituency with maximum votes

SELECT CODE AS CONSTITUENCY_CODE,
       CONSTITUENCY,
       STATE,
       SUM(VOTES) AS TOTAL_VOTES
FROM assembly_elections_may2026 a
LEFT JOIN election_gates eg ON eg.code = a.code
AND eg.status = 'EXCLUDE'
WHERE eg.code IS NULL
GROUP BY STATE,
         CODE,
         CONSTITUENCY
ORDER BY STATE ASC,
         TOTAL_VOTES DESC;

-- Min Total Votes Constituency

SELECT CODE AS CONSTITUENCY_CODE,
       CONSTITUENCY,
       STATE,
       SUM(VOTES) AS TOTAL_VOTES
FROM assembly_elections_may2026 a
LEFT JOIN election_gates eg ON eg.code = a.code
AND eg.status = 'EXCLUDE'
WHERE eg.code IS NULL
GROUP BY STATE,
         CODE,
         CONSTITUENCY
ORDER BY STATE ASC,
         TOTAL_VOTES ASC;

-- Max candidates in a Constituency

SELECT CODE AS CONSTITUENCY_CODE,
       CONSTITUENCY,
       STATE,
       COUNT(CANDIDATE) AS NO_OF_CANDIDATES
FROM assembly_elections_may2026 a
LEFT JOIN election_gates eg ON eg.code = a.code
AND eg.status = 'EXCLUDE'
WHERE eg.code IS NULL
GROUP BY STATE,
         CODE,
         CONSTITUENCY
ORDER BY STATE ASC,
         NO_OF_CANDIDATES DESC;

-- Least candidates in a Constituency

SELECT CODE AS CONSTITUENCY_CODE,
       CONSTITUENCY,
       STATE,
       COUNT(CANDIDATE) AS NO_OF_CANDIDATES
FROM assembly_elections_may2026 a
LEFT JOIN election_gates eg ON eg.code = a.code
AND eg.status = 'EXCLUDE'
WHERE eg.code IS NULL
GROUP BY STATE,
         CODE,
         CONSTITUENCY
ORDER BY STATE ASC,
         NO_OF_CANDIDATES ASC;
