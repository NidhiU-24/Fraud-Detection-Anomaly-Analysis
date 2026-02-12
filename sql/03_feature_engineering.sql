CREATE OR REPLACE TABLE model_features AS
SELECT
    *,
    LOG(Amount + 1) AS log_amount,
    CASE
        WHEN Amount < 10 THEN 'low'
        WHEN Amount < 100 THEN 'medium'
        ELSE 'high'
    END AS amount_category
FROM curated_transactions;
