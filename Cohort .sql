
-- Cohort analysis

WITH customer_cohort AS (
    SELECT
        customer_id,
        DATE_TRUNC(
            'month',
            MIN(transaction_date)
        )::DATE AS cohort_month
    FROM digital_commerce
    GROUP BY customer_id
),
customer_activity AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC(
            'month',
            transaction_date
        )::DATE AS activity_month
    FROM digital_commerce
),
cohort_data AS (
    SELECT
        c.customer_id,
        c.cohort_month,
        a.activity_month,

        (
            (
                EXTRACT(YEAR FROM a.activity_month)
                - EXTRACT(YEAR FROM c.cohort_month)
            ) * 12
            +
            (
                EXTRACT(MONTH FROM a.activity_month)
                - EXTRACT(MONTH FROM c.cohort_month)
            )
        )::INTEGER AS cohort_index

    FROM customer_cohort c

    JOIN customer_activity a
        ON c.customer_id = a.customer_id
),
cohort_size AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS total_customers
    FROM customer_cohort
    GROUP BY cohort_month
)
SELECT
    cd.cohort_month,
    cd.cohort_index,

    COUNT(
        DISTINCT cd.customer_id
    ) AS retained_customers,

    cs.total_customers AS cohort_size,

    ROUND(
        COUNT(DISTINCT cd.customer_id)
        * 100.0 / cs.total_customers,
        2
    ) AS retention_rate

FROM cohort_data cd

JOIN cohort_size cs
    ON cd.cohort_month = cs.cohort_month

WHERE cd.cohort_index BETWEEN 0 AND 6

GROUP BY
    cd.cohort_month,
    cd.cohort_index,
    cs.total_customers

ORDER BY
    cd.cohort_month,
    cd.cohort_index;