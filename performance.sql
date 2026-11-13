
-- 1. Brand performance


SELECT
    COALESCE(
        NULLIF(TRIM(brand), ''),
        'Unknown'
    ) AS brand,

    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(total) AS total_revenue,
    ROUND(AVG(total), 2) AS average_transaction_value,

    ROUND(
        SUM(total) * 100.0
        / SUM(SUM(total)) OVER (),
        2
    ) AS revenue_contribution_percentage

FROM digital_commerce

GROUP BY COALESCE(
    NULLIF(TRIM(brand), ''),
    'Unknown'
)

ORDER BY total_revenue DESC;

-- 2. Category performance

SELECT
    COALESCE(
        NULLIF(TRIM(category), ''),
        'Unknown'
    ) AS category,

    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(total) AS total_revenue,
    ROUND(AVG(total), 2) AS average_transaction_value,

    ROUND(
        SUM(total) * 100.0
        / SUM(SUM(total)) OVER (),
        2
    ) AS revenue_contribution_percentage

FROM digital_commerce

GROUP BY COALESCE(
    NULLIF(TRIM(category), ''),
    'Unknown'
)

ORDER BY total_revenue DESC;


-- 3. Payment method performance

SELECT
    COALESCE(
        NULLIF(TRIM(payment_method), ''),
        'Unknown'
    ) AS payment_method,

    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(total) AS total_revenue,

    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (),
        2
    ) AS transaction_percentage

FROM digital_commerce

GROUP BY COALESCE(
    NULLIF(TRIM(payment_method), ''),
    'Unknown'
)

ORDER BY total_transactions DESC