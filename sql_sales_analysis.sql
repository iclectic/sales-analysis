-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
	transactions_id INT PRIMARY KEY,
	sale_date	DATE,
	sale_time   TIME,
	customer_id	INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

SELECT * FROM retail_sales 
LIMIT 10

SELECT 
	COUNT(*) 
FROM retail_sales 

-- Data Cleaning
SELECT * FROM retail_sales
WHERE
	 transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time is NULL
	 OR
	 customer_id is NULL
	 OR
	 gender is NULL
	 OR
	 age is NULL
	 OR
	 category is NULL
	 OR
	 quantity is NULL
	 OR
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR 
	 total_sale is NULL

DELETE FROM retail_sales
WHERE
	 transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time is NULL
	 OR
	 customer_id is NULL
	 OR
	 gender is NULL
	 OR
	 age is NULL
	 OR
	 category is NULL
	 OR
	 quantity is NULL
	 OR
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR 
	 total_sale is NULL


-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many customers we have?

SELECT COUNT (customer_id) as total_sale FROM retail_sales

-- How many unique customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales





-- Write a SQL query to find the total sales for male and female customers in the 'Clothing' category.
-- Write a SQL query to list transactions where the sale was made after 5:00 PM.
-- Write a SQL query to retrieve all transactions where the sale was made before 9:00 AM.
-- Write a SQL query to calculate the total sales made for each price_per_unit range (e.g. 0-100, 101-200, etc.).
-- Write a SQL query to find all transactions made in the year 2022.
-- Write a SQL query to find the top 5 customers based on the highest total sales.
-- Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year.
-- Write a SQL query to retrieve all columns for sales made on '2022-11-22'.
-- Write a SQL query to retrieve all transactions where the category is 'Electronics' and the quantity sold is more than 15 in the month of Nov-2022.
-- Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category.
-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Write a SQL query to calculate the percentage of transactions made by each gender.
-- Write a SQL query to find the number of unique customers who purchased items from each category.
-- Write a SQL query to retrieve transactions where the total_sale is less than the cost (cogs).
-- Write a SQL query to find the highest quantity sold for each category.
-- Write a SQL query to find transactions where the quantity sold is above the average quantity.
-- Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).
-- Write a SQL query to calculate the total sales (total_sale) for each category.
-- Write a SQL query to count the total number of transactions per month.
-- Write a SQL query to retrieve transactions where the customer is aged 18 or younger and the total_sale is more than 100.
-- Write a SQL query to retrieve all transactions made on weekends (Saturday and Sunday).
-- Write a SQL query to find the total quantity sold for each customer age group (0-20, 21-40, 41-60, 61+).
-- Write a SQL query to find the total sales made for customers older than 60 in the 'Electronics' category.
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Write a SQL query to retrieve the minimum, maximum, and average total sales for each category.
-- Write a SQL query to find transactions where the sale was made by customers above the age of 50.
-- Write a SQL query to retrieve the top 3 categories by total number of transactions.
-- Write a SQL query to find the average quantity sold per category.
-- Write a SQL query to list transactions made by female customers where the total_sale is between 500 and 1000.
-- Write a SQL query to find the total revenue for each transaction.








-- Write a SQL query to find the total sales for male and female customers in the 'Clothing' category.
SELECT 
    gender, 
    SUM(total_sale) AS total_sales
FROM retail_sales
WHERE category = 'Clothing'
GROUP BY gender;


-- Write a SQL query to list transactions where the sale was made after 5:00 PM.
SELECT * 
FROM retail_sales
WHERE sale_time > '17:00:00';


-- Write a SQL query to retrieve all transactions where the sale was made before 9:00 AM.
SELECT * 
FROM retail_sales
WHERE sale_time < '09:00:00';


-- Write a SQL query to calculate the total sales made for each price_per_unit range (e.g. 0-100, 101-200, etc.).
SELECT 
    CASE 
        WHEN price_per_unit BETWEEN 0 AND 100 THEN '0-100'
        WHEN price_per_unit BETWEEN 101 AND 200 THEN '101-200'
        WHEN price_per_unit BETWEEN 201 AND 300 THEN '201-300'
        ELSE '300+'
    END AS price_range,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY price_range;


-- Write a SQL query to find all transactions made in the year 2022.
SELECT * 
FROM retail_sales
WHERE EXTRACT(YEAR FROM sale_date) = 2022;


-- Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT
	customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year.
SELECT 
	year,
	month,
    avg_sale
FROM
(
SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) AS t1
WHERE rank = 1;


-- Write a SQL query to retrieve all columns for sales made on '2022-11-22'.
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-22';


-- Write a SQL query to retrieve all transactions where the category is 'Electronics' and the quantity sold is more than 15 in the month of Nov-2022.
SELECT * 
FROM retail_sales
WHERE category = 'Electronics'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-12'
AND quantity >= 2;


-- Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category.
SELECT 
	ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Clothing';


-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;


-- Write a SQL query to calculate the percentage of transactions made by each gender.
SELECT 
    gender, 
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM retail_sales), 2) AS percentage
FROM retail_sales
GROUP BY gender;


-- Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	category,
	COUNT(customer_id) as count_of_unique_customers
FROM retail_sales
GROUP BY category;


-- Write a SQL query to retrieve transactions where the total_sale is less than the cost (cogs).
SELECT * 
FROM retail_sales
WHERE total_sale < cogs;


-- Write a SQL query to find the highest quantity sold for each category.
SELECT 
    category, 
    MAX(quantity) AS max_quantity
FROM retail_sales
GROUP BY category;


-- Write a SQL query to find transactions where the quantity sold is above the average quantity.
WITH avg_qty AS (
    SELECT AVG(quantity) AS avg_quantity 
    FROM retail_sales
)
SELECT * 
FROM retail_sales
WHERE quantity > (SELECT avg_quantity FROM avg_qty);


-- Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12  THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;


-- Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;


-- Write a SQL query to count the total number of transactions per month.
SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS month, 
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY month;


-- Write a SQL query to retrieve transactions where the customer is aged 18 or younger and the total_sale is more than 100.
SELECT * 
FROM retail_sales
WHERE age <= 18 
AND total_sale > 100;


-- Write a SQL query to retrieve all transactions made on weekends (Saturday and Sunday).
SELECT * 
FROM retail_sales
WHERE EXTRACT(DOW FROM sale_date) IN (6, 7);


-- Write a SQL query to find the total quantity sold for each customer age group (0-20, 21-40, 41-60, 61+).
SELECT 
    CASE 
        WHEN age BETWEEN 0 AND 20 THEN '0-20'
        WHEN age BETWEEN 21 AND 40 THEN '21-40'
        WHEN age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '61+'
    END AS age_group, 
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY age_group;


-- Write a SQL query to find the total sales made for customers older than 60 in the 'Electronics' category.
SELECT 
    SUM(total_sale) AS total_sales
FROM retail_sales
WHERE age > 60 
AND category = 'Electronics';


-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category,
	gender,
	COUNT(transaction_id) as num_transactions
FROM retail_sales
GROUP BY 1,2;


-- Write a SQL query to retrieve the minimum, maximum, and average total sales for each category.
SELECT 
    category, 
    MIN(total_sale) AS min_sale, 
    MAX(total_sale) AS max_sale, 
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY category;


-- Write a SQL query to find transactions where the sale was made by customers above the age of 50.
SELECT * 
FROM retail_sales
WHERE age > 50;


-- Write a SQL query to retrieve the top 3 categories by total number of transactions.
SELECT 
    category, 
    COUNT(transaction_id) AS transaction_count
FROM retail_sales
GROUP BY category
ORDER BY transaction_count DESC
LIMIT 3;


-- Write a SQL query to find the average quantity sold per category.
SELECT 
    category, 
    AVG(quantity) AS avg_quantity
FROM retail_sales
GROUP BY category;


-- Write a SQL query to list transactions made by female customers where the total_sale is between 500 and 1000.
SELECT * 
FROM retail_sales
WHERE gender = 'Female' 
AND total_sale BETWEEN 500 AND 1000;


-- Write a SQL query to find the total revenue for each transaction.
SELECT 
    transaction_id, 
    quantity * price_per_unit AS revenue
FROM retail_sales;
