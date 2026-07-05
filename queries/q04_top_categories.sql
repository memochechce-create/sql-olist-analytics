-- Вопрос: какие 10 товарных категорий приносят больше всего выручки?

SELECT
    -- используем английское название категории, если перевод есть
    COALESCE(t.product_category_name_english, p.product_category_name) AS category,
    COUNT(oi.order_id) AS items_sold,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
-- LEFT JOIN, чтобы не потерять товары без перевода категории
LEFT JOIN product_category_translation t
       ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;