-- Вопрос: насколько быстро доставляются заказы и как часто +
-- фактическая доставка опаздывает относительно обещанной даты?

SELECT
    COUNT(*) AS delivered_orders,
    -- среднее фактическое время доставки в днях
    ROUND(AVG(EXTRACT(EPOCH FROM (order_delivered_customer_date - order_purchase_timestamp)) / 86400), 1) AS avg_delivery_days,
    -- доля заказов, доставленных позже обещанной даты
    ROUND(
        100.0 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS late_delivery_pct
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;   -- берём только реально доставленные