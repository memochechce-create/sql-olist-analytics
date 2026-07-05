-- Вопрос: как менялась месячная выручка и каков прирост
-- относительно предыдущего месяца (MoM)?

SELECT
    date_trunc('month', o.order_purchase_timestamp) AS order_month,
    SUM(oi.price) AS revenue,
    -- выручка предыдущего месяца
    LAG(SUM(oi.price)) OVER (ORDER BY date_trunc('month', o.order_purchase_timestamp)) AS prev_revenue,
    -- абсолютный прирост
    SUM(oi.price) - LAG(SUM(oi.price)) OVER (ORDER BY date_trunc('month', o.order_purchase_timestamp)) AS mom_change
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'          -- учитываем только выполненные заказы
GROUP BY order_month
ORDER BY order_month;