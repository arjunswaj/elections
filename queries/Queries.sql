-- Create the database first if it doesn't exist
-- CREATE DATABASE elections;
 -- Connect to the database
-- \c elections
 -- Connect as postgres to the elections database
psql -h 192.168.64.3 -U postgres -d elections
-- Then run these commands in the elections database:
GRANT ALL ON SCHEMA PUBLIC TO arjunswaj;


ALTER SCHEMA PUBLIC OWNER TO arjunswaj;

-- Also grant database-level privileges:
GRANT ALL PRIVILEGES ON DATABASE elections TO arjunswaj;

-- Exit and reconnect as arjunswaj
\q
DROP TABLE IF EXISTS assembly_elections_may2026;


CREATE TABLE assembly_elections_may2026 (id SERIAL PRIMARY KEY,
                                                   code VARCHAR(10) NOT NULL,
                                                                    state VARCHAR(100) NOT NULL,
                                                                                       constituency VARCHAR(100) NOT NULL,
                                                                                                                 constituency_id INT NOT NULL,
                                                                                                                                     candidate VARCHAR(100) NOT NULL,
                                                                                                                                                            party VARCHAR(100) NOT NULL,
                                                                                                                                                                               evm_votes INT NOT NULL,
                                                                                                                                                                                             postal_votes INT NOT NULL,
                                                                                                                                                                                                              votes INT NOT NULL,
                                                                                                                                                                                                                        vote_percentage NUMERIC(7, 3) NOT NULL);


CREATE INDEX idx_assembly_elections_may2026_candidate ON assembly_elections_may2026 (candidate);

\copy assembly_elections_may2026 (id, code, state, constituency, constituency_id, candidate, party, evm_votes, postal_votes, votes, vote_percentage)
FROM '/Users/arjun/Developer/haskell/elections/election_results.csv' WITH (FORMAT csv,
                                                                           HEADER FALSE);


SELECT setval(pg_get_serial_sequence('assembly_elections_may2026', 'id'),
                (SELECT COALESCE(MAX(id), 1)
                 FROM assembly_elections_may2026));

ANALYZE assembly_elections_may2026;

-- Election gates: constituencies to exclude (e.g., repolls, deferred elections)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'election_gate_status') THEN
    CREATE TYPE election_gate_status AS ENUM ('EXCLUDE', 'INCLUDE');
  END IF;
END
$$;


CREATE TABLE IF NOT EXISTS election_gates (code VARCHAR(10) NOT NULL,
                                                            state VARCHAR(100) NOT NULL,
                                                                               status election_gate_status NOT NULL DEFAULT 'EXCLUDE',
                                                                                                                            UNIQUE (code,
                                                                                                                                    status));

-- Populate excluded constituencies (total votes = 0)

INSERT INTO election_gates (code, state, status)
SELECT DISTINCT code,
                state,
                'EXCLUDE'::election_gate_status
FROM assembly_elections_may2026
WHERE code IN
    (SELECT code
     FROM assembly_elections_may2026
     GROUP BY state,
              code
     HAVING SUM(votes) = 0) ON CONFLICT (code,
                                         status) DO NOTHING;


SELECT *
FROM election_gates;


SELECT *
FROM assembly_elections_may2026
LIMIT 25;


SELECT COUNT(*)
FROM assembly_elections_may2026;
