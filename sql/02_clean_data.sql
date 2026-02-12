CREATE OR REPLACE TABLE curated_transactions AS
SELECT *
FROM raw_transactions
WHERE Amount > 0;
