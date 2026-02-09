-- ==========================================
-- 02_user_modeling.sql
-- Purpose:
-- Convert transaction-level data
-- into user-level lifecycle metrics
-- ==========================================

CREATE TABLE users AS
SELECT
  customer_id,
  MIN(invoice_date) AS first_order_date,
  MAX(invoice_date) AS last_order_date,
  COUNT(DISTINCT invoice_no) AS total_orders,
  SUM(order_value) AS total_revenue
FROM orders
GROUP BY customer_id;
