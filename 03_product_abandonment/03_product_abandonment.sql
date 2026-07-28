SELECT DISTINCT
    items.item_name,
    COUNT(*) AS event_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS items
WHERE LOWER(items.item_name) LIKE '%sticker%'
GROUP BY items.item_name
ORDER BY event_count DESC;

SELECT
    event_name,
    COUNT(DISTINCT user_pseudo_id) AS unique_users,
    SUM(items.quantity) AS total_quantity,
    ROUND(SUM(items.item_revenue), 2) AS total_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS items
WHERE items.item_name = 'Android Large Removable Sticker Sheet'
AND event_name IN ('view_item', 'add_to_cart', 'purchase')
GROUP BY event_name
ORDER BY unique_users DESC;