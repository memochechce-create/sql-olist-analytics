-- Вопрос: какие товарные категории имеют самые высокие
-- и самые низкие средние оценки покупателей?

SELECT
    COALESCE(t.product_category_name_english, p.product_category_name) AS category,
    COUNT(r.review_id) AS reviews_count,
    ROUND(AVG(r.review_score), 2) AS avg_score
FROM order_reviews r
JOIN order_items oi ON r.order_id = oi.order_id
JOIN products p     ON oi.product_id = p.product_id
LEFT JOIN product_category_translation t
       ON p.product_category_name = t.product_category_name
GROUP BY category
HAVING COUNT(r.review_id) >= 100            -- только категории с достаточным числом отзывов
ORDER BY avg_score DESC;