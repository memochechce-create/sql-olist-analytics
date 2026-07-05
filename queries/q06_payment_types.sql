-- Вопрос: какими способами клиенты платят чаще всего
-- и какова доля каждого способа в общей выручке?
SELECT
    payment_type,
    COUNT(*) AS payments_count,
    ROUND(AVG(payment_installments), 1) AS avg_installments,   -- среднее число платежей в рассрочку
    ROUND(SUM(payment_value), 2) AS total_value,
    -- доля способа оплаты в общей сумме
    ROUND(100.0 * SUM(payment_value) / SUM(SUM(payment_value)) OVER (), 1) AS pct_of_total
FROM order_payments
GROUP BY payment_type
ORDER BY total_value DESC;