
-- transaction & cust analysis --


-- 1. Overall transaction KPI

SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT store_id) AS total_stores,
    SUM(total) AS total_revenue,
    ROUND(AVG(total), 2) AS average_transaction_value,
    SUM(qty) AS total_quantity
FROM digital_commerce;


-- 2. Monthly transaction trend

SELECT
    DATE_TRUNC(
        'month',
        transaction_date
    )::DATE AS transaction_month,

    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS active_customers,
    SUM(total) AS monthly_revenue,
    ROUND(AVG(total), 2) AS average_transaction_value,
    SUM(qty) AS total_quantity

FROM digital_commerce

GROUP BY DATE_TRUNC(
    'month',
    transaction_date
)

ORDER BY transaction_month;


-- 3. Repeat customer analysis

WITH customer_transactions AS (
    SELECT
        customer_id,
        COUNT(*) AS transaction_count,
        SUM(total) AS customer_revenue
    FROM digital_commerce
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE transaction_count = 1
    ) AS one_time_customers,

    COUNT(*) FILTER (
        WHERE transaction_count > 1
    ) AS repeat_customers,

    ROUND(
        COUNT(*) FILTER (
            WHERE transaction_count > 1
        ) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_rate,

    ROUND(
        AVG(transaction_count),
        2
    ) AS average_transactions_per_customer

FROM customer_transactions;


-- 4. Monthly new and returning customer analysis

WITH customer_first_month AS (
    SELECT
        customer_id,
        DATE_TRUNC(
            'month',
            MIN(transaction_date)
        )::DATE AS first_month
    FROM digital_commerce
    GROUP BY customer_id
),
monthly_customer_activity AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC(
            'month',
            transaction_date
        )::DATE AS transaction_month
    FROM digital_commerce
)
SELECT
    m.transaction_month,
    COUNT(*) AS active_customers,

    COUNT(*) FILTER (
        WHERE m.transaction_month = f.first_month
    ) AS new_customers,

    COUNT(*) FILTER (
        WHERE m.transaction_month > f.first_month
    ) AS returning_customers,

    ROUND(
        COUNT(*) FILTER (
            WHERE m.transaction_month > f.first_month
        ) * 100.0 / COUNT(*),
        2
    ) AS returning_customer_percentage

FROM monthly_customer_activity m

JOIN customer_first_month f
    ON m.customer_id = f.customer_id

GROUP BY m.transaction_month
ORDER BY m.transaction_month;