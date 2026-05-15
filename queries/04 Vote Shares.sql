-- Total Vote Share
-- Vote Shares by Party

SELECT PARTY_VOTE_DETAILS.STATE AS STATE,
       PARTY_VOTE_DETAILS.PARTY AS PARTY,
       PARTY_VOTE_DETAILS.PARTY_VOTES AS PARTY_VOTES,
       (PARTY_VOTE_DETAILS.PARTY_VOTES::numeric / NULLIF(TOTAL_VOTE_DETAILS.TOTAL_VOTES, 0) * 100) AS VOTE_SHARE
FROM
  (SELECT STATE,
          PARTY,
          SUM(VOTES) AS PARTY_VOTES
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL
   GROUP BY STATE,
            PARTY) AS PARTY_VOTE_DETAILS,

  (SELECT STATE,
          SUM(VOTES) AS TOTAL_VOTES
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL
   GROUP BY STATE) AS TOTAL_VOTE_DETAILS
WHERE PARTY_VOTE_DETAILS.STATE = TOTAL_VOTE_DETAILS.STATE
ORDER BY STATE ASC,
         PARTY_VOTES DESC;

-- Least Vote share for a winning candidate

SELECT v.STATE AS STATE,
       v.CANDIDATE AS CANDIDATE,
       v.PARTY AS PARTY,
       v.CONSTITUENCY AS CONSTITUENCY,
       v.VOTE_SHARE AS VOTE_SHARE
FROM
  (SELECT ger.STATE AS STATE,
          ger.CANDIDATE AS CANDIDATE,
          ger.PARTY AS PARTY,
          ger.CONSTITUENCY AS CONSTITUENCY,
          ger.VOTES AS VOTES,
          ger.CODE AS CODE,
          VOTE_DETAILS.TOTAL_VOTES AS TOTAL_VOTES,
          (ger.VOTES::numeric / NULLIF(VOTE_DETAILS.TOTAL_VOTES, 0) * 100) AS VOTE_SHARE
   FROM
     (SELECT STATE,
             CODE,
             CONSTITUENCY,
             SUM(VOTES) AS TOTAL_VOTES
      FROM assembly_elections_may2026 a
      LEFT JOIN election_gates eg ON eg.code = a.code
      AND eg.status = 'EXCLUDE'
      WHERE eg.code IS NULL
      GROUP BY STATE,
               CODE,
               CONSTITUENCY) AS VOTE_DETAILS
   JOIN assembly_elections_may2026 ger ON VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY
   AND VOTE_DETAILS.STATE = ger.STATE
   AND VOTE_DETAILS.CODE = ger.CODE
   LEFT JOIN election_gates eg ON eg.code = ger.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL) AS v
JOIN
  (SELECT STATE,
          CODE,
          CONSTITUENCY,
          MAX(VOTES) AS MAX_VOTES
   FROM assembly_elections_may2026 a
   LEFT JOIN election_gates eg ON eg.code = a.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL
   GROUP BY STATE,
            CODE,
            CONSTITUENCY) AS WINNERS ON v.CONSTITUENCY = WINNERS.CONSTITUENCY
AND v.STATE = WINNERS.STATE
AND v.CODE = WINNERS.CODE
AND v.VOTES = WINNERS.MAX_VOTES
ORDER BY STATE ASC,
         VOTE_SHARE ASC;

-- Max Vote share of a losing candidate

SELECT t2.STATE AS STATE,
       t2.CANDIDATE AS CANDIDATE,
       t2.PARTY AS PARTY,
       t2.CONSTITUENCY AS CONSTITUENCY,
       t2.VOTE_PERCENTAGE AS RUNNER_UP_VOTE_PERCENTAGE
FROM assembly_elections_may2026 t2
LEFT JOIN election_gates eg2 ON eg2.code = t2.code
AND eg2.status = 'EXCLUDE'
JOIN
  (SELECT t.STATE,
          t.CODE,
          t.CONSTITUENCY,
          MAX(t.VOTES) AS RUNNER_VOTES
   FROM assembly_elections_may2026 t
   LEFT JOIN election_gates egt ON egt.code = t.code
   AND egt.status = 'EXCLUDE'
   JOIN
     (SELECT STATE,
             CODE,
             CONSTITUENCY,
             MAX(VOTES) AS MAX_VOTES
      FROM assembly_elections_may2026 a
      LEFT JOIN election_gates eg ON eg.code = a.code
      AND eg.status = 'EXCLUDE'
      WHERE eg.code IS NULL
      GROUP BY STATE,
               CODE,
               CONSTITUENCY) sub ON t.STATE = sub.STATE
   AND t.CODE = sub.CODE
   AND t.CONSTITUENCY = sub.CONSTITUENCY
   AND t.VOTES < sub.MAX_VOTES
   WHERE egt.code IS NULL
   GROUP BY t.STATE,
            t.CODE,
            t.CONSTITUENCY) sub2 ON t2.STATE = sub2.STATE
AND t2.CODE = sub2.CODE
AND t2.CONSTITUENCY = sub2.CONSTITUENCY
AND t2.VOTES = sub2.RUNNER_VOTES
WHERE eg2.code IS NULL
ORDER BY STATE ASC,
         RUNNER_UP_VOTE_PERCENTAGE DESC;

-- LOST Deposits

SELECT DEPOSIT_LOSERS.STATE AS STATE,
       DEPOSIT_LOSERS.PARTY,
       COUNT(DEPOSIT_LOSERS.PARTY) AS NO_OF_CANDIDATES_WITH_LESS_THAN_ONE_SIXTH_VOTES
FROM
  (SELECT ger.STATE,
          ger.CANDIDATE,
          ger.PARTY,
          ger.CONSTITUENCY,
          ger.VOTES,
          VOTE_DETAILS.TOTAL_VOTES,
          (ger.VOTES::numeric / NULLIF(VOTE_DETAILS.TOTAL_VOTES, 0)) AS VOTE_SHARE
   FROM
     (SELECT STATE,
             CODE,
             CONSTITUENCY,
             SUM(VOTES) AS TOTAL_VOTES
      FROM assembly_elections_may2026 a
      LEFT JOIN election_gates eg ON eg.code = a.code
      AND eg.status = 'EXCLUDE'
      WHERE eg.code IS NULL
      GROUP BY STATE,
               CODE,
               CONSTITUENCY) AS VOTE_DETAILS
   JOIN assembly_elections_may2026 ger ON (VOTE_DETAILS.CONSTITUENCY = ger.CONSTITUENCY)
   AND (VOTE_DETAILS.STATE = ger.STATE)
   AND (VOTE_DETAILS.CODE = ger.CODE)
   LEFT JOIN election_gates eg ON eg.code = ger.code
   AND eg.status = 'EXCLUDE'
   WHERE eg.code IS NULL) DEPOSIT_LOSERS
WHERE VOTE_SHARE < (1.0 / 6)
  AND PARTY <> 'NONE OF THE ABOVE'
GROUP BY DEPOSIT_LOSERS.STATE,
         DEPOSIT_LOSERS.PARTY
ORDER BY STATE ASC,
         NO_OF_CANDIDATES_WITH_LESS_THAN_ONE_SIXTH_VOTES DESC;
