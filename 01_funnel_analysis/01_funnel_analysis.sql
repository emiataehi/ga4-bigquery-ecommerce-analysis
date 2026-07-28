SELECT *
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20201101`
LIMIT 1;

SELECT
    event_name,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name IN ('session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY event_name
ORDER BY unique_users DESC;


SELECT
    params.key,
    params.value.float_value,
    params.value.int_value,
    params.value.string_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(event_params) AS params
WHERE event_name = 'purchase'
LIMIT 20;

SELECT
    ROUND(SUM(
        (SELECT value.int_value 
         FROM UNNEST(event_params) 
         WHERE key = 'value')
    ), 2) AS total_revenue,
    COUNT(DISTINCT user_pseudo_id) AS total_purchasers,
    ROUND(SUM(
        (SELECT value.int_value 
         FROM UNNEST(event_params) 
         WHERE key = 'value')
    ) / COUNT(DISTINCT user_pseudo_id), 2) AS avg_revenue_per_purchaser
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase';


SELECT
    ROUND(SUM(
        (SELECT COALESCE(value.float_value, value.int_value)
         FROM UNNEST(event_params) 
         WHERE key = 'value')
    ), 2) AS total_revenue,
    COUNT(DISTINCT user_pseudo_id) AS total_purchasers,
    ROUND(SUM(
        (SELECT COALESCE(value.float_value, value.int_value)
         FROM UNNEST(event_params) 
         WHERE key = 'value')
    ) / COUNT(DISTINCT user_pseudo_id), 2) AS avg_revenue_per_purchaser
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase';





