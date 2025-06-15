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
FROM retail_sale
LIMIT 10;
-- DATA CLEANING--
SELECT *
FROM retail_sale
WHERE 
transactions_id IS NULL
OR 
sale_date IS NULL 
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR
gender IS NULL;