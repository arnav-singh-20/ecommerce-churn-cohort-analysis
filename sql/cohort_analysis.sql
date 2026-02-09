-- ==========================================
-- 05_cohort_analysis.sql
-- Purpose:
-- Perform cohort-based retention analysis
-- ==========================================

-- Step 1: Assign users to cohorts (signup month)
CREATE TABLE user_cohorts AS
SELECT
  customer_id,
  SUBSTR(first_order_date, 1, 7) AS cohort_month
FROM users;

-- Step 2: Attach cohort info to orders
CREATE TABLE orders_with_cohort AS
SELECT
  o.customer_id,
  o.invoice_date,
  c.cohort_month,
  SUBSTR(o.invoice_date, 1, 7) AS order_month
FROM orders o
JOIN user_cohorts c
  ON o.customer_id = c.customer_id;

-- Step 3: Calculate cohort index (months since signup)
CREATE TABLE cohort_activity AS
SELECT
  cohort_month,
  order_month,
  (
    (CAST(SUBSTR(order_month, 1, 4) AS INTEGER) -
     CAST(SUBSTR(cohort_month, 1, 4) AS INTEGER)) * 12
    +
    (CAST(SUBSTR(order_month, 6, 2) AS INTEGER) -
     CAST(SUBSTR(cohort_month, 6, 2) AS INTEGER))
  ) AS cohort_index,
  customer_id
FROM orders_with_cohort;

-- Step 4: Count active users per cohort per month
CREATE TABLE cohort_retention AS
SELECT
  cohort_month,
  cohort_index,
  COUNT(DISTINCT customer_id) AS active_users
FROM cohort_activity
GROUP BY cohort_month, cohort_index;

-- Step 5: Calculate cohort sizes
CREATE TABLE cohort_size AS
SELECT
  cohort_month,
  COUNT(DISTINCT customer_id) AS cohort_users
FROM user_cohorts
GROUP BY cohort_month;

-- Step 6: Final retention rate (normalized)
SELECT
  r.cohort_month,
  r.cohort_index,
  r.active_users,
  s.cohort_users,
  ROUND(r.active_users * 1.0 / s.cohort_users, 3) AS retention_rate
FROM cohort_retention r
JOIN cohort_size s
  ON r.cohort_month = s.cohort_month
ORDER BY r.cohort_month, r.cohort_index;
