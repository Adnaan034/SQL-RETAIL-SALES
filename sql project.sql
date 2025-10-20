select* from retail_sales;
--                                                         Data Cleaning part  
select * from retail_sales
where transaction_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null 
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null 
or total_sale is null;

select count(*) from retail_sales
where age is null;


select * from retail_sales
where age = 'Null';

select age, length(age)
from retail_sales
where age = '' or age=' ';

desc retail_sales;

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_sale_date,
    SUM(CASE WHEN age = '' THEN 1 ELSE 0 END) AS empty_sale_date,
    SUM(CASE WHEN age = ' ' THEN 1 ELSE 0 END) AS space_sale_date,
    SUM(CASE WHEN age = 'NULL' THEN 1 ELSE 0 END) AS string_null_sale_date
FROM retail_sales;

select count(*) from retail_sales;

                                                                 --  Data Exploration

-- how many total sales are there?
SELECT 
    SUM(total_sale)
FROM
    retail_sales;

-- how many sales we have ? 
SELECT 
    COUNT(*) AS total_sales
FROM
    retail_sales;

-- how many Unique customers we have ?
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    retail_sales;

-- how many categories we have ?
SELECT DISTINCT
    category AS total_categories
FROM
    retail_sales;

--                                                                Data Analysis & Business key Problems  and answers

-- Q.1 write sql query to retrive all columns for sales  made on 2022-11-05 ?
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Q.2 write sql query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of 
-- Nov 2022 ?

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity >= 4
        AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'; 


-- Q.3 write sql query to calculate total sales for each category ?
SELECT DISTINCT
    category, SUM(total_sale), COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category;

-- Q.4 Write Sql query to find avg age of customers who purchased items from the Beauty category ?
SELECT 
    customer_id, AVG(age) AS Age, total_sale
FROM
    retail_sales
WHERE
    category = 'Beauty'
GROUP BY customer_id , total_sale;


-- Q.5 to find all transactions where the total sales is greater than 1000 ?
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

-- Q.6 find total number of transactions made by each gender in each category ?
SELECT 
    gender, category, COUNT(*) AS total_transactions
FROM
    retail_sales
GROUP BY gender , category;

-- Q.7 calculate the avg sales for each month. find out best selling month in each year ?
select * from retail_sales;

SELECT 
    year,
    month,
    sales,
    RANK() OVER (PARTITION BY year ORDER BY sales DESC) AS rank_in_year
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS sales
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_avg;

-- Q.8 Find the top five customers based on the highest total sales ?
Select * from retail_sales;

SELECT customer_id, category, sum(total_sale) as Highest_sales
from retail_sales
group by customer_id, category
order by Highest_sales DESC LIMIT 5;

-- Q.9 Find the number of unique customers who purchased items from each category ?
Select * from retail_sales;

SELECT 
 category, count(DISTINCT customer_id) as Unique_customer
from retail_sales
group by category; 

-- Q.10 Create each shift and number of orders(Example Morning >=12, Afternoon Between 12 & 17 Evening >17) ?
Select * from retail_sales;

with hourly_table
as (
Select *,
case
when extract(hour from sale_time) <=12 Then 'Morning'
when extract(hour from sale_time) Between 12 and 17 Then 'Afternoon'
ELSE 'Evening'
end as shifts 
from retail_sales
)
select shifts, count(*) as Total_orders
from hourly_table
group by shifts;

-- Q.11 which day has the highest sales ?
select * from retail_sales;

with day_name     --  CTE (common Table Expression) 
As (
Select * ,
dayname(sale_date) as Day_name,
monthname(sale_date) as month
from retail_sales
)
select Day_name,month,sum(total_sale) as Highest_sales
from day_name
group by Day_name,month
order by Highest_sales Desc Limit 5;

-- Q.12 How much profit has got in which year ?
select * from retail_sales;

select year(sale_date) as years, (sum(total_sale) - sum(cogs)) as Profit
from retail_sales
group by years
order by Profit Desc Limit 1;

-- Q.13 Which product purchased less in which year ?
select * from retail_sales;

SELECT DISTINCT year(sale_date) as Years , category , sum(total_sale) as Sales
FROM retail_sales
GROUP BY Years, category
LIMIT 1;

-- Q. 14 which age-group people has maximum purchased ?
SELECT age, category, sum(total_sale) AS Sales
FROM retail_sales
GROUP BY age, category
ORDER BY Sales DESC
LIMIT 5;

--                                                                 END OF PROJECT