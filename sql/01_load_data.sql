CREATE OR REPLACE TABLE raw_transactions AS
SELECT *
FROM read_csv_auto('creditcard.csv');
