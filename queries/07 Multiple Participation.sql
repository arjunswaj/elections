-- Multiple seats participating candidates
SELECT 
    CANDIDATE,
    COUNT(DISTINCT CONSTITUENCY) AS CONSTITUENCY_COUNT
FROM
    GENERAL_ELECTION_2024_RESULTS
WHERE
    CANDIDATE <> 'NOTA'
GROUP BY CANDIDATE , PARTY
ORDER BY CONSTITUENCY_COUNT DESC , CANDIDATE;


-- Multiple participation results
WITH candidate_participation AS (
    SELECT
        CANDIDATE,
        PARTY,
        COUNT(DISTINCT CONCAT(STATE, '_', CONSTITUENCY)) AS CONSTITUENCY_COUNT
    FROM GENERAL_ELECTION_2024_RESULTS
    GROUP BY CANDIDATE, PARTY
),
ranked_results AS (
    SELECT
        STATE,
        CONSTITUENCY,
        CANDIDATE,
        PARTY,
        VOTES,
        ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY ORDER BY VOTES DESC) AS rn
    FROM GENERAL_ELECTION_2024_RESULTS
)
SELECT
	r.CANDIDATE,
    r.CONSTITUENCY,
    r.STATE,
    r.PARTY,
    CASE WHEN r.rn = 1 THEN 'WON' ELSE 'LOST' END AS RESULT
FROM
    ranked_results r
JOIN
    candidate_participation cp
ON
    r.CANDIDATE = cp.CANDIDATE AND r.PARTY = cp.PARTY
WHERE
    cp.CONSTITUENCY_COUNT > 1 AND r.CANDIDATE <> 'NOTA'
ORDER BY
    RESULT DESC, r.PARTY, r.CANDIDATE;
