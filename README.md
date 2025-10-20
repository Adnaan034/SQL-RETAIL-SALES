# 🛍️ SQL_RETAIL
## 📘 Project Overview

SQL_RETAIL is an end-to-end retail sales analysis project using MySQL.
It includes data cleaning, exploration, and advanced SQL queries to extract business insights such as profit, customer behavior, category performance, and sales trends.

## 🧹 Data Cleaning
To find and handle missing or incorrect data values before performing analysis.
Missing or blank values can lead to inaccurate insights, so identifying them early is crucial.
```
SELECT * FROM retail_sales
WHERE transaction_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL 
OR age IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL 
OR total_sale IS NULL;
```

To check if there are any records with blank strings ('', ' ', 'NULL') instead of real NULL values — a common data quality issue.

```
SELECT age, LENGTH(age)
FROM retail_sales
WHERE age = '' OR age = ' ' OR age = 'NULL';
```

### 📊 Data Exploration

1️⃣ To calculate the total revenue (sum of all sales) in the dataset.
```
SELECT SUM(total_sale) FROM retail_sales;
```

2️⃣ Total Number of Transactions
- To count how many transactions occurred in total — helps understand dataset volume.
```
SELECT COUNT(*) AS total_sales FROM retail_sales;
```

3️⃣ Unique Customers
- To find the number of unique customers — helps measure customer reach and retention.
```

SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
```

4️⃣ Total Categories
- To identify all unique product categories available in the dataset.
```

SELECT DISTINCT category FROM retail_sales;
```

### 💡 Business Key Problems & SQL Queries
Q1️⃣ Sales made on 2022-11-05
- To view all transactions that occurred on a specific date — useful for daily performance tracking.
```

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

Q2️⃣ Transactions where category = ‘Clothing’ and quantity > 10 in Nov 2022
- To analyze bulk clothing sales during a specific month for demand insights.
```
SELECT * FROM retail_sales
WHERE category = 'Clothing' 
  AND quantity > 10
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

Q3️⃣ Total sales for each category
- To compare revenue contribution and order volume across product categories.
```
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

```
Q4️⃣ Average age of customers in Beauty category
- To understand the average customer age profile for the Beauty segment.
```
SELECT customer_id, AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY customer_id;
```

Q5️⃣ Transactions where total sales > 1000
- To identify high-value transactions that significantly contribute to revenue.
```
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```
Q6️⃣ Number of transactions by each gender and category
- To study purchasing patterns across genders and product categories.
```
SELECT gender, category, COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY gender, category;
```
Q7️⃣ Average sales for each month and best-selling month per year
- To calculate average monthly sales and rank the best-performing months annually.
```
SELECT year, month, sales,
RANK() OVER (PARTITION BY year ORDER BY sales DESC) AS rank_in_year
FROM (
    SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, AVG(total_sale) AS sales
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_avg;
```
Q8️⃣ Top 5 customers with highest total sales
- To find the most valuable customers contributing the highest sales revenue.
```
SELECT customer_id, category, SUM(total_sale) AS highest_sales
FROM retail_sales
GROUP BY customer_id, category
ORDER BY highest_sales DESC
LIMIT 5;
```
Q9️⃣ Unique customers per category
- To measure how many distinct customers purchased from each category — helpful for marketing segmentation.
```
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```
Q🔟 Orders by shift (Morning, Afternoon, Evening)
- To analyze transaction distribution across different time slots of the day.
```
WITH hourly_table AS (
SELECT *,
CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shifts
FROM retail_sales
)
SELECT shifts, COUNT(*) AS total_orders
FROM hourly_table
GROUP BY shifts;
```
Q1️⃣1️⃣ Day with the highest sales
- To find which weekday and month combination generated the maximum sales.
```
WITH day_name AS (
SELECT *,
DAYNAME(sale_date) AS Day_name,
MONTHNAME(sale_date) AS Month
FROM retail_sales
)
SELECT Day_name, Month, SUM(total_sale) AS Highest_sales
FROM day_name
GROUP BY Day_name, Month
ORDER BY Highest_sales DESC
LIMIT 5;
️```
Q1️⃣2️⃣ How much profit got in each year
- To calculate annual profit by subtracting the total cost of goods sold (COGS) from total sales.
```
SELECT YEAR(sale_date) AS years, 
(SUM(total_sale) - SUM(cogs)) AS profit
FROM retail_sales
GROUP BY years
ORDER BY profit DESC;
```
Q1️⃣3️⃣ Which product purchased less in which year
- To identify the least popular product category each year based on total sales.
```
SELECT YEAR(sale_date) AS years, category, SUM(total_sale) AS sales
FROM retail_sales
GROUP BY years, category
ORDER BY sales ASC
LIMIT 1;
```
Q1️⃣4️⃣ Which age group purchased the most
- To find which age group contributes the most to overall sales — useful for customer targeting.
```
SELECT age, category, SUM(total_sale) AS sales
FROM retail_sales
GROUP BY age, category
ORDER BY sales DESC
LIMIT 5;


### 🧾 Key Insights

- Highest profit year identified through SUM(total_sale) - SUM(cogs)

- Most active age groups and top 5 customers found using sales aggregation

- Clothing and Beauty emerged as high-revenue categories

- Morning and Afternoon shifts showed the highest number of orders

- Day and month-level ranking helped spot top-performing periods

### 🛠️ Tools Used

- MySQL Workbench – Query execution and visualization

- Excel / CSV Dataset – Initial data cleaning and structure check

- GitHub – Project documentation and version control

### 📂 Project Structure
SQL_RETAIL/
│
├── retail_sales.sql        # All SQL queries
├── dataset.csv             # Retail dataset
├── README.md               # Documentation file
└── output_screenshots/     # Optional: MySQL query results

### 👨‍💻 Author

Adnaan Shaikh
📊 Data Analyst | SQL | Power BI | Excel | Python
📫 LinkedIn
 | GitHub
