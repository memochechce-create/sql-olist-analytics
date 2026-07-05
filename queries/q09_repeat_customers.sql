-- Вопрос: какая доля клиентов делает повторные покупки,
-- а какая покупает только один раз?


WITH orders_per_customer AS (
    -- считаем число заказов у каждого уникального клиента
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE WHEN orders_count = 1 THEN 'one-time' ELSE 'repeat' END AS customer_type,
    COUNT(*) AS customers,
    -- доля сегмента от всех клиентов
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM orders_per_customer
GROUP BY customer_type;