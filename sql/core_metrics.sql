SELECT 
  ROUND(SUM(order_value), 2) AS total_revenue
FROM orders;
SELECT 
  COUNT(DISTINCT invoice_no) AS total_orders
FROM orders;
SELECT 
  ROUND(
    SUM(order_value) * 1.0 / COUNT(DISTINCT invoice_no),
    2
  ) AS AOV
FROM orders;
SELECT
  ROUND(
    SUM(order_value) * 1.0 / COUNT(DISTINCT customer_id),
    2
  ) AS ARPU
FROM orders;
SELECT
  country,
  ROUND(SUM(order_value), 2) AS revenue
FROM orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;
SELECT
  SUBSTR(invoice_date, 1, 7) AS year_month,
  ROUND(SUM(order_value), 2) AS monthly_revenue
FROM orders
GROUP BY year_month
ORDER BY year_month;
