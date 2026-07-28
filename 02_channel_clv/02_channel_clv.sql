SELECT
    traffic_source.medium AS channel,
    COUNT(DISTINCT user_pseudo_id) AS total_purchasers,
    SUM(
        (SELECT COALESCE(value.float_value, value.int_value)
         FROM UNNEST(event_params)
         WHERE key = 'value')
    ) AS total_revenue,
    ROUND(SUM(
        (SELECT COALESCE(value.float_value, value.int_value)
         FROM UNNEST(event_params)
         WHERE key = 'value')
    ) / COUNT(DISTINCT user_pseudo_id), 2) AS avg_revenue_per_user
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
GROUP BY channel
ORDER BY avg_revenue_per_user DESC;