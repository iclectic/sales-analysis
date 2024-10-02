# Retail Sales Data Repository
`<br>
This repository contains an Excel sheet of a retail sales dataset. The dataset includes various fields such as transaction details, customer demographics, sales figures, and more. The purpose of this dataset is to support data analysis, data cleaning, and querying exercises using SQL.

## Dataset Overview
`<br>
The dataset consists of sales records including:
`<br>
Transaction ID: Unique identifier for each sale.
Sale Date: Date when the transaction took place.
Sale Time: Time of the transaction.
Customer Information: ID, gender, and age.
Category: Product category (e.g., Electronics, Clothing).
Quantity: Number of units sold.
Price per Unit: The cost of one unit of the product.
COGS: Cost of Goods Sold.
Total Sale: Total revenue from the sale.

### Table Schema
`<br>
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date       DATE,
    sale_time       TIME,
    customer_id     INT,
    gender          VARCHAR(15),
    age             INT,
    category        VARCHAR(15),
    quantity        INT,
    price_per_unit  FLOAT,
    cogs            FLOAT,
    total_sale      FLOAT
);
`

## SQL Query Examples
`<br>
### Data Exploration
`<br>

- Count Total Sales
- `<br>
`
SELECT COUNT(*) AS total_sales FROM retail_sales;
`
- SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

`
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;
`
`<br>
### Data Cleaning
`<br>
- Find Records with Missing Values
- `<br>
`
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
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
`
<br>
- Delete Records with Missing Values
`<br>
`
DELETE FROM retail_sales
WHERE transactions_id IS NULL
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
`
`<br>
  ### Data Analysis
<br>
-  Total Sales by Price Per Unit Range
<br>
`
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
`
<br>
- Best-Selling Month in Each Year
`<br>
`
SELECT year, month, avg_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY year, month
) AS ranked_sales
WHERE rank = 1;
`
