-- Overall fraud rate
SELECT
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    ROUND(100.0 * SUM(Class) / COUNT(*), 4) AS fraud_percentage
FROM model_features;

-- Fraud rate by transaction size
SELECT
    amount_category,
    COUNT(*) AS total,
    SUM(Class) AS fraud_count,
    ROUND(100.0 * SUM(Class) / COUNT(*), 2) AS fraud_rate
FROM model_features
GROUP BY amount_category
ORDER BY fraud_rate DESC;
