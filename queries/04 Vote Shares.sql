-- Total Vote Share
SELECT 
    PARTY_VOTE_DETAILS.PARTY AS PARTY,
    PARTY_VOTE_DETAILS.PARTY_VOTES AS PARTY_VOTES,
    (PARTY_VOTE_DETAILS.PARTY_VOTES / TOTAL_VOTE_DETAILS.TOTAL_VOTES * 100) AS VOTE_SHARE
FROM
    (SELECT 
        PARTY, SUM(VOTES) AS PARTY_VOTES
    FROM
        INDIA_GENERAL_ELECTIONS.GENERAL_ELECTION_2024_RESULTS
    GROUP BY PARTY) AS PARTY_VOTE_DETAILS,
    (SELECT 
        SUM(VOTES) AS TOTAL_VOTES
    FROM
        INDIA_GENERAL_ELECTIONS.GENERAL_ELECTION_2024_RESULTS) AS TOTAL_VOTE_DETAILS
ORDER BY PARTY_VOTES DESC;

-- Maximum Vote share of Winning Candidate
SELECT 
    ger.CANDIDATE,
    ger.PARTY,
    ger.CONSTITUENCY,
    ger.STATE,
    (ger.VOTES / VOTE_DETAILS.TOTAL_VOTES * 100) AS VOTE_SHARE
FROM
    (SELECT 
        CONSTITUENCY, SUM(VOTES) AS TOTAL_VOTES
    FROM
        GENERAL_ELECTION_2024_RESULTS
    GROUP BY STATE , CONSTITUENCY) AS VOTE_DETAILS
        JOIN
    GENERAL_ELECTION_2024_RESULTS ger ON VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY
ORDER BY VOTE_SHARE DESC;

-- Least Vote share for a winning candidate
SELECT 
    v.CANDIDATE AS CANDIDATE,
    v.PARTY AS PARTY,
    v.CONSTITUENCY AS CONSTITUENCY,
    v.STATE AS STATE,
    v.VOTE_SHARE AS VOTE_SHARE
FROM
    (SELECT 
        ger.CANDIDATE AS CANDIDATE,
            ger.PARTY AS PARTY,
            ger.CONSTITUENCY AS CONSTITUENCY,
            ger.STATE AS STATE,
            ger.VOTES AS VOTES,
            ger.CODE AS CODE,
            VOTE_DETAILS.TOTAL_VOTES AS TOTAL_VOTES,
            (ger.VOTES / VOTE_DETAILS.TOTAL_VOTES * 100) AS VOTE_SHARE
    FROM
        (SELECT 
        CONSTITUENCY, STATE, SUM(VOTES) AS TOTAL_VOTES
    FROM
        GENERAL_ELECTION_2024_RESULTS
    GROUP BY STATE , CONSTITUENCY) AS VOTE_DETAILS
    JOIN GENERAL_ELECTION_2024_RESULTS ger ON VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY
        AND VOTE_DETAILS.STATE = ger.STATE) AS v
        JOIN
    (SELECT 
        STATE, CONSTITUENCY, MAX(VOTES) AS MAX_VOTES
    FROM
        GENERAL_ELECTION_2024_RESULTS
    GROUP BY STATE , CONSTITUENCY) AS WINNERS ON v.CONSTITUENCY = WINNERS.CONSTITUENCY
        AND v.STATE = WINNERS.STATE
        AND v.VOTES = WINNERS.MAX_VOTES
ORDER BY VOTE_SHARE ASC;

-- Max Vote share of a losing candidate
SELECT 
    t2.CANDIDATE AS CANDIDATE,
    t2.PARTY AS PARTY,
    t2.CONSTITUENCY AS CONSTITUENCY,
    t2.STATE AS STATE,
    t2.VOTE_PERCENTAGE AS RUNNER_UP_VOTE_PERCENTAGE
FROM
    GENERAL_ELECTION_2024_RESULTS t2
        JOIN
    (SELECT 
        t.STATE, t.CONSTITUENCY, MAX(t.VOTES) AS RUNNER_VOTES
    FROM
        GENERAL_ELECTION_2024_RESULTS t
    JOIN (SELECT 
        STATE, CONSTITUENCY, MAX(VOTES) AS MAX_VOTES
    FROM
        GENERAL_ELECTION_2024_RESULTS
    GROUP BY STATE , CONSTITUENCY) sub ON t.STATE = sub.STATE
        AND t.CONSTITUENCY = sub.CONSTITUENCY
        AND t.VOTES < sub.MAX_VOTES
    GROUP BY t.STATE , t.CONSTITUENCY) sub2 ON t2.STATE = sub2.STATE
        AND t2.CONSTITUENCY = sub2.CONSTITUENCY
        AND t2.VOTES = sub2.RUNNER_VOTES
ORDER BY RUNNER_UP_VOTE_PERCENTAGE DESC;

-- LOST Deposits
SELECT 
    DEPOSIT_LOSERS.PARTY,
    COUNT(DEPOSIT_LOSERS.PARTY) AS NO_OF_CANDIDATES_WITH_LESS_THAN_ONE_SIXTH_VOTES
FROM
    (SELECT 
        ger.CANDIDATE,
            ger.PARTY,
            ger.CONSTITUENCY,
            ger.VOTES,
            VOTE_DETAILS.TOTAL_VOTES,
            (ger.VOTES / VOTE_DETAILS.TOTAL_VOTES) AS VOTE_SHARE
    FROM
        (SELECT 
        CONSTITUENCY, STATE, SUM(VOTES) AS TOTAL_VOTES
    FROM
        GENERAL_ELECTION_2024_RESULTS
    GROUP BY STATE , CONSTITUENCY) AS VOTE_DETAILS
    JOIN GENERAL_ELECTION_2024_RESULTS ger ON (VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY)
        AND (VOTE_DETAILS.STATE = ger.STATE)) DEPOSIT_LOSERS
WHERE
    VOTE_SHARE < (1 / 6)
        AND PARTY <> 'NONE OF THE ABOVE'
GROUP BY DEPOSIT_LOSERS.PARTY
ORDER BY NO_OF_CANDIDATES_WITH_LESS_THAN_ONE_SIXTH_VOTES DESC;

