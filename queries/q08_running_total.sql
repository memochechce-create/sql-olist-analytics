-- Вопрос: как растёт накопленная выручка нарастающим итогом по месяцам?

WITH monthly AS (
    SELECT
        date_trunc('month', o.order_purchase_timestamp) AS order_month,
        SUM(oi.price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY order_month
)
SELECT
    order_month,
    revenue,
    -- накопительный итог (сумма всех месяцев до текущего включительно)
    SUM(revenue) OVER (ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
FROM monthly
ORDER BY order_month;