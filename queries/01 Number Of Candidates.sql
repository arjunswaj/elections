-- Number of candidates
-- Number of candidates by party and state
SELECT 
    STATE, PARTY, COUNT(*) AS NO_OF_CANDIDATES
FROM
    assembly_elections_may2026
WHERE
    CANDIDATE <> 'NOTA'
GROUP BY STATE, PARTY
ORDER BY STATE ASC, NO_OF_CANDIDATES DESC;

-- Number of votes by state
SELECT 
    STATE, SUM(VOTES) AS NO_OF_VOTES
FROM
    assembly_elections_may2026
GROUP BY STATE
ORDER BY STATE ASC;

-- Number of candidates by state
SELECT 
    STATE, COUNT(*) AS NO_OF_CANDIDATES
FROM
    assembly_elections_may2026
WHERE
    CANDIDATE <> 'NOTA'
GROUP BY STATE
ORDER BY STATE ASC;