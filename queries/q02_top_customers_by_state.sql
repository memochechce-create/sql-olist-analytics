-- Вопрос: кто топ-3 клиента по суммарной выручке в каждом штате?

WITH customer_revenue AS (
    -- суммируем выручку по каждому уникальному клиенту и его штату
    SELECT
        c.customer_state,
        c.customer_unique_id,
        SUM(oi.price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN customers c    ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_state, c.customer_unique_id
),
ranked AS (
    -- ранжируем клиентов внутри каждого штата по убыванию выручки
    SELECT *,
        RANK() OVER (PARTITION BY customer_state ORDER BY revenue DESC) AS rnk
    FROM customer_revenue
)
SELECT customer_state, customer_unique_id, revenue, rnk
FROM ranked
WHERE rnk <= 3                              -- оставляем только топ-3 в каждом штате
ORDER BY customer_state, rnk;