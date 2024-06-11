-- All Parties
SELECT DISTINCT
    PARTY
FROM
    GENERAL_ELECTION_2024_RESULTS
WHERE
    PARTY NOT IN ('INDEPENDENT' , 'NOTA')
ORDER BY PARTY;

-- Gold Medals
SELECT
    PARTY,
    COUNT(*) AS SEATS_WON
FROM
    (SELECT
        STATE,
        CONSTITUENCY,
        PARTY,
        VOTES,
        ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY ORDER BY VOTES DESC) AS rn
     FROM GENERAL_ELECTION_2024_RESULTS
    ) AS ranked_results
WHERE rn = 1
GROUP BY PARTY
ORDER BY SEATS_WON DESC;

-- Silver Medals
SELECT
    PARTY,
    COUNT(*) AS SILVER_MEDALS
FROM
    (SELECT
        STATE,
        CONSTITUENCY,
        PARTY,
        VOTES,
        ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY ORDER BY VOTES DESC) AS rn
     FROM GENERAL_ELECTION_2024_RESULTS
    ) AS ranked_results
WHERE rn = 2
GROUP BY PARTY
ORDER BY SILVER_MEDALS DESC;
