-- Вопрос: какие категории формируют основную часть выручки (ABC-анализ)?
-- A = верхние ~80% выручки, B = следующие ~15%, C = оставшиеся ~5%.//


WITH category_revenue AS (
    SELECT
        COALESCE(t.product_category_name_english, p.product_category_name) AS category,
        SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_translation t
           ON p.product_category_name = t.product_category_name
    GROUP BY category
),
cumulative AS (
    SELECT
        category,
        revenue,
        -- накопительная доля выручки нарастающим итогом (в процентах)
        100.0 * SUM(revenue) OVER (ORDER BY revenue DESC)
              / SUM(revenue) OVER () AS cum_pct
    FROM category_revenue
)
SELECT
    category,
    ROUND(revenue, 2) AS revenue,
    ROUND(cum_pct, 1) AS cumulative_pct,
    -- относим категорию к группам A/B/C
    CASE
        WHEN cum_pct <= 80 THEN 'A'
        WHEN cum_pct <= 95 THEN 'B'
        ELSE 'C'
    END AS abc_group
FROM cumulative
ORDER BY revenue DESC;