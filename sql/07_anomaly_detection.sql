--------------------------------------------------
-- 1️⃣ Calculate Global Mean & Std Dev
--------------------------------------------------

WITH stats AS (
    SELECT
        AVG(Amount) AS mean_amount,
        STDDEV_POP(Amount) AS std_amount
    FROM model_features
),

--------------------------------------------------
-- 2️⃣ Compute Z-Score
--------------------------------------------------

z_scores AS (
    SELECT
        m.*,
        (m.Amount - s.mean_amount) / s.std_amount AS z_score
    FROM model_features m
    CROSS JOIN stats s
)

--------------------------------------------------
-- 3️⃣ Flag Anomalies
--------------------------------------------------

SELECT
    CASE
        WHEN ABS(z_score) > 3 THEN 'Anomaly'
        ELSE 'Normal'
    END AS anomaly_flag,
    
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_count,
    ROUND(100.0 * SUM(Class) / COUNT(*), 3) AS fraud_rate
FROM z_scores
GROUP BY anomaly_flag
ORDER BY fraud_rate DESC;
