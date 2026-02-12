--------------------------------------------------
-- 1️⃣ Fraud vs Non-Fraud Distribution
--------------------------------------------------

SELECT
    Class,
    COUNT(*) AS transaction_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 4) AS percentage_of_total
FROM model_features
GROUP BY Class
ORDER BY Class;


--------------------------------------------------
-- 2️⃣ Average & Median Transaction Amount (Fraud vs Legit)
--------------------------------------------------

SELECT
    Class,
    AVG(Amount) AS avg_amount,
    MEDIAN(Amount) AS median_amount,
    MAX(Amount) AS max_amount,
    MIN(Amount) AS min_amount
FROM model_features
GROUP BY Class;


--------------------------------------------------
-- 3️⃣ Fraud Rate by Amount Category
--------------------------------------------------

SELECT
    amount_category,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(100.0 * SUM(Class) / COUNT(*), 3) AS fraud_rate_percent
FROM model_features
GROUP BY amount_category
ORDER BY fraud_rate_percent DESC;


--------------------------------------------------
-- 4️⃣ Top 10 Highest Fraud Amounts
--------------------------------------------------

SELECT
    Amount,
    log_amount
FROM model_features
WHERE Class = 1
ORDER BY Amount DESC
LIMIT 10;


--------------------------------------------------
-- 5️⃣ Fraud Probability by Log Amount Buckets
--------------------------------------------------

SELECT
    ROUND(log_amount, 0) AS log_bucket,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(100.0 * SUM(Class) / COUNT(*), 3) AS fraud_rate
FROM model_features
GROUP BY log_bucket
HAVING COUNT(*) > 100
ORDER BY fraud_rate DESC;
