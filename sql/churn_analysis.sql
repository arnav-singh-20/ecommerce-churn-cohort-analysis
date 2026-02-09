-- ==========================================
-- 04_churn_analysis.sql
-- Purpose:
-- Identify churned vs active users
-- based on inactivity threshold
-- ==========================================

-- Churn definition:
-- A user is churned if inactive for > 90 days
-- relative to the latest order date in dataset

CREATE TABLE user_churn AS
SELECT
  customer_id,
  first_order_date,
  last_order_date,
  total_orders,
  total_revenue,
  CASE
    WHEN julianday((SELECT MAX(invoice_date) FROM orders))
         - julianday(last_order_date) > 90
    THEN 'Churned'
    ELSE 'Active'
  END AS churn_status
FROM users;

-- Churn distribution
SELECT
  churn_status,
  COUNT(*) AS users
FROM user_churn
GROUP BY churn_status;

-- Compare engagement and value
SELECT
  churn_status,
  ROUND(AVG(total_orders), 2) AS avg_orders,
  ROUND(AVG(total_revenue), 2) AS avg_revenue
FROM user_churn
GROUP BY churn_status;
