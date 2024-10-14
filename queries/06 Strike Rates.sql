-- Cost per vote (Do best and worst)
SELECT 
    STATE,
    PARTY,
    TOTAL_COST,
    PARTY_VOTES,
    (TOTAL_COST / PARTY_VOTES) AS COST_PER_VOTE
FROM
    (SELECT 
        GER.STATE AS STATE,
        (COUNT(GER.CANDIDATE) * 4000000) AS TOTAL_COST,
        GER.PARTY AS PARTY,
        PARTY_VOTE_DETAILS.PARTY_VOTES AS PARTY_VOTES
    FROM
        ASSEMBLY_ELECTIONS_OCT2024 GER
    JOIN (SELECT 
        STATE,
        PARTY, 
        SUM(VOTES) AS PARTY_VOTES
    FROM
        ASSEMBLY_ELECTIONS_OCT2024
    GROUP BY STATE, PARTY) AS PARTY_VOTE_DETAILS ON GER.STATE = PARTY_VOTE_DETAILS.STATE AND GER.PARTY = PARTY_VOTE_DETAILS.PARTY
    GROUP BY GER.STATE, GER.PARTY) COST_ANALYSIS
ORDER BY STATE ASC, COST_PER_VOTE ASC;

-- Strike Rate - Best
SELECT
    p.STATE,
    p.PARTY,
    p.SEATS_PARTICIPATED,
    w.SEATS_WON,
    (w.SEATS_WON / p.SEATS_PARTICIPATED * 100) AS SUCCESS_RATIO
FROM
    (SELECT
        STATE,
        PARTY,
        COUNT(DISTINCT CONCAT(STATE, '_', CONSTITUENCY)) AS SEATS_PARTICIPATED
     FROM ASSEMBLY_ELECTIONS_OCT2024
     GROUP BY STATE, PARTY
    ) p
LEFT JOIN
    (SELECT
        STATE,
        PARTY,
        COUNT(*) AS SEATS_WON
     FROM
        (SELECT
            STATE,
            CONSTITUENCY,
            PARTY,
            VOTES,
            ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY ORDER BY VOTES DESC) AS rn
         FROM ASSEMBLY_ELECTIONS_OCT2024
        ) ranked_results
     WHERE rn = 1
     GROUP BY STATE, PARTY
    ) w
ON p.STATE = w.STATE AND p.PARTY = w.PARTY
ORDER BY STATE ASC, SUCCESS_RATIO DESC, SEATS_PARTICIPATED DESC;

-- Strike Rate - Worst (at least 1 win)
SELECT
    p.STATE,
    p.PARTY,
    p.SEATS_PARTICIPATED,
    w.SEATS_WON,
    (w.SEATS_WON / p.SEATS_PARTICIPATED * 100) AS SUCCESS_RATIO
FROM
    (SELECT
        STATE,
        PARTY,
        COUNT(DISTINCT CONCAT(STATE, '_', CONSTITUENCY)) AS SEATS_PARTICIPATED
     FROM ASSEMBLY_ELECTIONS_OCT2024
     GROUP BY STATE, PARTY
    ) p
LEFT JOIN
    (SELECT
        STATE,
        PARTY,
        COUNT(*) AS SEATS_WON
     FROM
        (SELECT
            STATE,
            CONSTITUENCY,
            PARTY,
            VOTES,
            ROW_NUMBER() OVER (PARTITION BY STATE, CONSTITUENCY ORDER BY VOTES DESC) AS rn
         FROM ASSEMBLY_ELECTIONS_OCT2024
        ) ranked_results
     WHERE rn = 1
     GROUP BY STATE, PARTY
    ) w
ON p.STATE = w.STATE AND p.PARTY = w.PARTY
WHERE w.SEATS_WON >= 1
ORDER BY STATE ASC, SUCCESS_RATIO ASC, SEATS_PARTICIPATED DESC;