--------------------------------------------------
-- 1️⃣ Create Risk Scoring Table
--------------------------------------------------

CREATE OR REPLACE TABLE fraud_risk_scored AS
SELECT
    *,
    
    -- Log bucket
    ROUND(log_amount, 0) AS log_bucket,
    
    -- Risk from log bucket
    CASE 
        WHEN ROUND(log_amount, 0) IN (0, 3) THEN 3
        WHEN ROUND(log_amount, 0) = 2 THEN 2
        ELSE 1
    END AS log_risk_score,
    
    -- Risk from amount category
    CASE
        WHEN amount_category IN ('low', 'high') THEN 2
        ELSE 1
    END AS category_risk_score

FROM model_features;


--------------------------------------------------
-- 2️⃣ Create Total Risk Score
--------------------------------------------------

CREATE OR REPLACE TABLE fraud_risk_final AS
SELECT
    *,
    (log_risk_score + category_risk_score) AS total_risk_score
FROM fraud_risk_scored;


--------------------------------------------------
-- 3️⃣ Risk Score Distribution
--------------------------------------------------

SELECT
    total_risk_score,
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(100.0 * SUM(Class) / COUNT(*), 3) AS fraud_rate
FROM fraud_risk_final
GROUP BY total_risk_score
ORDER BY fraud_rate DESC;
