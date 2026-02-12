CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
CREATE SCHEMA IF NOT EXISTS ops;

CREATE TABLE IF NOT EXISTS ops.pipeline_run_log (
  run_id        TEXT PRIMARY KEY,
  pipeline_name TEXT NOT NULL,
  started_at    TIMESTAMP NOT NULL DEFAULT NOW(),
  ended_at      TIMESTAMP NULL,
  status        TEXT NOT NULL,
  details       JSONB NULL
);
