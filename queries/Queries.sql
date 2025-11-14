-- Create the database first if it doesn't exist
-- CREATE DATABASE elections;

-- Connect to the database
-- \c elections

DROP TABLE IF EXISTS assembly_elections_nov2025;

CREATE TABLE assembly_elections_nov2025 (
  id SERIAL PRIMARY KEY,
  code VARCHAR(10) NOT NULL,
  state VARCHAR(100) NOT NULL,
  constituency VARCHAR(100) NOT NULL,
  constituency_id INT NOT NULL,
  candidate VARCHAR(100) NOT NULL,
  party VARCHAR(100) NOT NULL,
  evm_votes INT NOT NULL,
  postal_votes INT NOT NULL,
  votes INT NOT NULL,
  vote_percentage NUMERIC(7,3) NOT NULL
);

CREATE INDEX idx_assembly_elections_nov2025_candidate
  ON assembly_elections_nov2025 (candidate);

\copy assembly_elections_nov2025 (id, code, state, constituency, constituency_id, candidate, party, evm_votes, postal_votes, votes, vote_percentage)
FROM '/Users/arjun/Developer/haskell/elections/election_results.csv'
WITH (FORMAT csv, HEADER false);

SELECT setval(
  pg_get_serial_sequence('assembly_elections_nov2025', 'id'),
  (SELECT COALESCE(MAX(id), 1) FROM assembly_elections_nov2025)
);

ANALYZE assembly_elections_nov2025;

SELECT * FROM assembly_elections_nov2025 LIMIT 25;

SELECT COUNT(*) FROM assembly_elections_nov2025;