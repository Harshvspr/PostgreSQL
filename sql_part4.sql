-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
SELECT *
FROM retail_sales
LIMIT 10;
-- DATA CLEANING--
SELECT *
FROM retail_sales
WHERE 
transaction_id IS NULL
OR 
sale_date IS NULL 
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR
gender IS NULL
OR
total_sale IS NULL;
-- DELETE NULL VALUE--
DELETE FROM retail_sales 
WHERE 
transaction_id IS NULL
OR 
sale_date IS NULL 
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR
gender IS NULL
OR
total_sale IS NULL;
-- Data exploration--
SELECT COUNT (total_sale)
FROM retail_sales
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND 
 TO_CHAR(sale_date,'yyyy-MM')= '2022-11' AND
 quantity >= 4;
 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 SELECT sum(total_sale)AS net_sale,category,
 COUNT(*) AS total_orders
 FROM retail_sales
 GROUP BY category;
 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(avg(age),2)AS avg_age,category
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale>1000
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT sum(transaction_id),gender,category
FROM retail_sales
GROUP BY gender,category;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
  EXTRACT(YEAR FROM sale_date) AS Year,
  EXTRACT(MONTH FROM sale_date) AS Month,
  ROUND(AVG(total_sale)::numeric, 2) AS avg_sales,
  RANK() OVER (
    PARTITION BY EXTRACT(YEAR FROM sale_date) 
    ORDER BY ROUND(AVG(total_sale)::numeric, 2) ASC
  ) AS rank_in_year
FROM retail_sales
GROUP BY 
  EXTRACT(YEAR FROM sale_date),
  EXTRACT(MONTH FROM sale_date)
ORDER BY 
  rank_in_year;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales--
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
SELECT category,count(DISTINCT customer_id)
FROM retail_sales
GROUP BY category;
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 SELECT sale_time
 FROM retail_sales