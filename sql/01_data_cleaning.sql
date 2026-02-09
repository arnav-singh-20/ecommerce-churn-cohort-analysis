-- ==========================================
-- 01_data_cleaning.sql
-- Purpose:
-- 1. Rename raw imported columns
-- 2. Assign business meaning
-- 3. Clean invalid and cancelled transactions
-- ==========================================

-- Step 1: Create semantic raw_orders table
CREATE TABLE raw_orders AS
SELECT
  field1 AS invoice_no,
  field2 AS stock_code,
  field3 AS description,
  CAST(field4 AS INTEGER) AS quantity,
  field5 AS invoice_date,
  CAST(field6 AS REAL) AS unit_price,
  CAST(field7 AS INTEGER) AS customer_id,
  field8 AS country
FROM data;

-- Step 2: Create clean orders table using business rules
CREATE TABLE orders AS
SELECT
  invoice_no,
  stock_code,
  description,
  quantity,
  invoice_date,
  unit_price,
  customer_id,
  country,
  quantity * unit_price AS order_value
FROM raw_orders
WHERE invoice_no NOT LIKE 'C%'        -- remove cancelled orders
  AND quantity > 0                    -- remove invalid quantity
  AND unit_price > 0                  -- remove invalid price
  AND customer_id IS NOT NULL;         -- ensure user-level analysis
