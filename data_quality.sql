--Data quality

-- 1. Dataset overview

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS unique_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT store_id) AS unique_stores,
    MIN(transaction_date) AS first_date,
    MAX(transaction_date) AS last_date,
    COUNT(
        DISTINCT DATE_TRUNC('month', transaction_date)
    ) AS total_months
FROM digital_commerce;


-- 2. Check null and invalid values

SELECT
    COUNT(*) FILTER (
        WHERE transaction_date IS NULL
    ) AS null_dates,

    COUNT(*) FILTER (
        WHERE transaction_id IS NULL
        OR TRIM(transaction_id) = ''
    ) AS null_transactions,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL
        OR TRIM(customer_id) = ''
    ) AS null_customers,

    COUNT(*) FILTER (
        WHERE store_id IS NULL
        OR TRIM(store_id) = ''
    ) AS null_stores,

    COUNT(*) FILTER (
        WHERE total IS NULL OR total <= 0
    ) AS invalid_total,

    COUNT(*) FILTER (
        WHERE qty IS NULL OR qty <= 0
    ) AS invalid_qty
FROM digital_commerce;


-- 3. Check duplicate transaction IDs

SELECT
    COUNT(*) AS duplicate_transaction_ids
FROM (
    SELECT
        transaction_id
    FROM digital_commerce
    GROUP BY transaction_id
    HAVING COUNT(*) > 1
) AS duplicate_list;


-- 4. Check transaction status distribution

SELECT
    TRIM(status) AS transaction_status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM digital_commerce
GROUP BY TRIM(status)
ORDER BY total_transactions DESC;