WITH cohort_data AS (
  SELECT 
    u.customer_id,
    DATE_TRUNC('month', u.first_order_date) AS cohort_month,
    DATE_TRUNC('month', o.invoice_date) AS order_month
  FROM users u
  JOIN orders o
    ON u.customer_id = o.customer_id
),
cohort_activity AS (
  SELECT 
    cohort_month,
    order_month,
    DATE_DIFF('month', cohort_month, order_month) AS cohort_index,
    customer_id
  FROM cohort_data
),
retention AS (
  SELECT 
    cohort_month,
    cohort_index,
    COUNT(DISTINCT customer_id) AS active_users
  FROM cohort_activity
  GROUP BY cohort_month, cohort_index
),
cohort_size AS (
  SELECT 
    cohort_month,
    COUNT(DISTINCT customer_id) AS total_users
  FROM cohort_data
  GROUP BY cohort_month
)
SELECT 
  r.cohort_month,
  r.cohort_index,
  active_users,
  total_users,
  active_users * 1.0 / total_users AS retention_rate
FROM retention r
JOIN cohort_size s
  ON r.cohort_month = s.cohort_month
ORDER BY 1, 2;
