-- Вопрос: какой средний чек (AOV) и как он меняется по месяцам?

WITH order_totals AS (
    -- шаг 1: сумма каждого отдельного заказа
    SELECT
        o.order_id,
        date_trunc('month', o.order_purchase_timestamp) AS order_month,
        SUM(oi.price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id, order_month
)
-- шаг 2: усредняем суммы заказов по месяцам
SELECT
    order_month,
    COUNT(*) AS orders_count,
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM order_totals
GROUP BY order_month
ORDER BY order_month;