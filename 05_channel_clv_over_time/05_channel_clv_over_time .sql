WITH first_visit AS (
    SELECT
        user_pseudo_id,
        traffic_source.medium AS channel,
        MIN(event_timestamp) AS first_visit_timestamp
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    GROUP BY user_pseudo_id, channel
),

purchases AS (
    SELECT
        user_pseudo_id,
        event_timestamp,
        (SELECT COALESCE(value.float_value, value.int_value)
         FROM UNNEST(event_params)
         WHERE key = 'value') AS revenue
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    WHERE event_name = 'purchase'
)

SELECT
    f.channel,
    COUNT(DISTINCT CASE WHEN (p.event_timestamp - f.first_visit_timestamp) / 1000000 / 86400 <= 30 THEN p.user_pseudo_id END) AS users_30days,
    ROUND(SUM(CASE WHEN (p.event_timestamp - f.first_visit_timestamp) / 1000000 / 86400 <= 30 THEN p.revenue END), 2) AS revenue_30days,
    COUNT(DISTINCT CASE WHEN (p.event_timestamp - f.first_visit_timestamp) / 1000000 / 86400 <= 60 THEN p.user_pseudo_id END) AS users_60days,
    ROUND(SUM(CASE WHEN (p.event_timestamp - f.first_visit_timestamp) / 1000000 / 86400 <= 60 THEN p.revenue END), 2) AS revenue_60days,
    COUNT(DISTINCT CASE WHEN (p.event_timestamp - f.first_visit_timestamp) / 1000000 / 86400 <= 90 THEN p.user_pseudo_id END) AS users_90days,
    ROUND(SUM(CASE WHEN (p.event_timestamp - f.first_visit_timestamp) / 1000000 / 86400 <= 90 THEN p.revenue END), 2) AS revenue_90days
FROM first_visit f
JOIN purchases p ON f.user_pseudo_id = p.user_pseudo_id
GROUP BY f.channel
ORDER BY revenue_90days DESC