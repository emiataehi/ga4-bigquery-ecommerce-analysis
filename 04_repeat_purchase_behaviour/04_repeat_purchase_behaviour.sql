WITH user_purchases AS (
    SELECT
        user_pseudo_id,
        COUNT(*) AS purchase_count,
        SUM(
            (SELECT COALESCE(value.float_value, value.int_value)
             FROM UNNEST(event_params)
             WHERE key = 'value')
        ) AS total_spent
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    WHERE event_name = 'purchase'
    GROUP BY user_pseudo_id
)

SELECT
    CASE 
        WHEN purchase_count = 1 THEN 'One-time buyer'
        WHEN purchase_count > 1 THEN 'Repeat buyer'
    END AS buyer_type,
    COUNT(*) AS total_users,
    ROUND(AVG(total_spent), 2) AS avg_revenue_per_user,
    ROUND(SUM(total_spent), 2) AS total_revenue
FROM user_purchases
GROUP BY buyer_type
ORDER BY avg_revenue_per_user DESC