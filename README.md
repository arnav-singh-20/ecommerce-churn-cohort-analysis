# ecommerce-churn-cohort-analysis
To analyze customer purchasing behavior and identify revenue stagnation drivers by examining:  customer churn  retention patterns  cohort-wise behavior using SQL-driven analytics on transactional e-commerce data.
# Customer Churn & Cohort Analysis using SQL

## 📌 Project Overview
This project analyzes customer purchasing behavior for an e-commerce business to identify **churn drivers**, **retention patterns**, and **reasons for revenue stagnation**.  
The analysis is performed entirely using **SQL**, following an industry-style analytics workflow from raw data cleaning to cohort-based retention analysis.

---

## 🎯 Business Problem
Despite steady customer acquisition, overall revenue shows signs of stagnation.  
The objective is to determine whether this issue is caused by:
- declining customer retention,
- early customer churn,
- or changes in customer behavior over time.

---

## 📂 Dataset Description
- **Type:** Transaction-level e-commerce data  
- **Granularity:** One row per product per invoice  
- **Size:** ~540,000 records  
- **Key Columns:**  
  - `invoice_no` – Order identifier  
  - `invoice_date` – Date of transaction  
  - `customer_id` – Unique customer identifier  
  - `quantity`, `unit_price` – Order details  
  - `country` – Customer location  

> The raw dataset is not included in the repository due to size and licensing constraints.

---

## 🏗️ Project Structure & Methodology

### 1️⃣ Data Cleaning & Preparation
- Renamed cryptic columns and assigned business meaning
- Casted appropriate data types
- Removed:
  - cancelled orders,
  - invalid quantities and prices,
  - anonymous customers
- Created a clean **orders** table with derived `order_value`

### 2️⃣ User-Level Modeling
Built a **users** table to model customer lifecycle metrics:
- first order date (acquisition)
- last order date (recency)
- total orders (engagement)
- total revenue (lifetime value base)

---

## 📊 Core Business Metrics
Calculated key performance indicators:
- Total Revenue  
- Total Orders  
- Average Order Value (AOV)  
- Average Revenue Per User (ARPU)  
- Revenue by country  
- Monthly revenue trends  

These metrics established a reliable baseline for further analysis.

---

## 🔁 Churn Analysis
### Churn Definition
A customer is considered **churned** if they placed no orders in the **last 90 days**, relative to the latest date in the dataset.

### Key Findings
- Churned users place significantly fewer orders
- Churned users generate substantially lower lifetime revenue
- Churn is predominantly **early-lifecycle driven**

---

## 📦 Cohort & Retention Analysis
### Cohort Definition
Customers grouped by **month of first purchase**.

### Retention Logic
Tracked whether users from each cohort returned in subsequent months.

### Normalization
Retention was calculated as a percentage of the original cohort size to ensure fair comparison across cohorts.

### Insights
- Newer cohorts exhibit steeper early drop-offs
- Retention declines within the first 1–2 months after acquisition
- Indicates onboarding or early value-delivery issues

---

## 📌 Key Business Insights
- Revenue stagnation is driven by **poor early-stage retention**, not acquisition
- Users who churn early contribute minimal lifetime value
- Improving early retention could significantly increase overall revenue

---

## 💡 Recommendations
- Improve onboarding experience for new customers
- Introduce incentives for second and third purchases
- Focus retention strategies on first 30–60 days of user lifecycle
- Target underperforming cohorts with personalized engagement

---

## 🛠️ Tools & Skills Demonstrated
- Advanced SQL (joins, aggregations, CASE WHEN, subqueries)
- Data cleaning using business rules
- Churn modeling
- Cohort-based retention analysis
- Analytical thinking & business insight generation

---

## 📎 Repository Contents
- `/sql` – SQL scripts for cleaning, modeling, churn, and cohort analysis  
- `/insights` – Summary of findings and interpretations  


