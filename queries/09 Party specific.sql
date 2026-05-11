WITH ranked_results AS (
    SELECT
        STATE,
        CONSTITUENCY,
        CODE,
        CANDIDATE,
        PARTY,
        VOTES,
        ROW_NUMBER() OVER (PARTITION BY STATE, CODE ORDER BY VOTES DESC) AS rn
    FROM assembly_elections_may2026
),
winner_and_runner_up AS (
    SELECT
        r1.STATE,
        r1.CONSTITUENCY,
        r1.CODE,
        r1.PARTY AS WINNING_PARTY,
        r1.VOTES AS WINNING_VOTES,
        r2.PARTY AS RUNNER_UP_PARTY,
        r2.VOTES AS RUNNER_UP_VOTES
    FROM
        ranked_results r1
    JOIN
        ranked_results r2
    ON
        r1.STATE = r2.STATE AND r1.CONSTITUENCY = r2.CONSTITUENCY AND r1.CODE = r2.CODE
    WHERE
        r1.rn = 1 AND r2.rn = 2
)
SELECT
    STATE,
    CONSTITUENCY,
    CODE AS CONSTITUENCY_CODE,
    RUNNER_UP_VOTES,
    WINNING_PARTY,
    WINNING_VOTES,
    (WINNING_VOTES - RUNNER_UP_VOTES) AS VOTE_DIFFERENCE
FROM
    winner_and_runner_up
WHERE
    RUNNER_UP_PARTY = 'Bharatiya Janata Party'
    AND (WINNING_VOTES - RUNNER_UP_VOTES) < 50000
ORDER BY
    STATE ASC,
    VOTE_DIFFERENCE ASC;
