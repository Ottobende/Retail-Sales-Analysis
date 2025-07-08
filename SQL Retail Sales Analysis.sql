--- SQL Retail Sales Analysis
--- Data Cleaning

--- Create Table 
DROP TABLE IF EXIST retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(20),
				age INT,
				category VARCHAR(20),	
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,	
				total_sale FLOAT
			);

SELECT COUNT(*) 
FROM retail_sales;


SELECT *
FROM retail_sales
WHERE 
	 transactions_id is null
	 OR
	 sale_date is null
	 OR
	 sale_time is null
	 or
	 customer_id is null
	 or 
	 gender is null 
	 or
	 age is null
	 or
	 category is null
	 or
	 quantity is null 
	 or
	 price_per_unit is null 
	 or
	 cogs is null
	 or
	 total_sale is null
	 ;

	 
DELETE FROM retail_sales
WHERE 
	 transactions_id is null
	 OR
	 sale_date is null
	 OR
	 sale_time is null
	 or
	 customer_id is null
	 or 
	 gender is null 
	 or
	 age is null
	 or
	 category is null
	 or
	 quantity is null 
	 or
	 price_per_unit is null 
	 or
	 cogs is null
	 or
	 total_sale is null
	 ;

--- Data Exploration
--- How many sales  do we have

SELECT COUNT(*) AS Total_Sales
FROM retail_sales;

--- How many unique customers do we have

SELECT COUNT(DISTINCT customer_id) AS number_of_customers
FROM retail_sales;

--- How many categories do we have 

SELECT COUNT(DISTINCT category)
FROM retail_sales;

SELECT DISTINCT category
FROM retail_sales;

---- Data Analysis & Business key problems and solutions
---- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM retail_sales;

SELECT*
FROM retail_sales
WHERE sale_date='2022-11-05';

---- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM retail_sales
WHERE category='Clothing'
	AND 
	TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
	AND
	quantity>=4;

--- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT*
FROM retail_sales;

SELECT SUM(total_sale)
FROM retail_sales
WHERE category='Clothing';

SELECT SUM(total_sale)
FROM retail_sales
WHERE category='Beauty';

SELECT SUM(total_sale)
FROM retail_sales
WHERE category='Electronics';

SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total
FROM retail_sales
GROUP BY category;

--- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT ROUND(AVG(AGE), 2) AS avg_age
FROM retail_sales
WHERE category='Beauty';

--- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT*
FROM retail_sales;

SELECT*
FROM retail_sales
WHERE total_sale>1000;

--- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT category, gender, COUNT(*) AS total_cat
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

--- Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT
	  year,
	  month,
	  avg_sale
FROM 
(
	SELECT
		 EXTRACT(YEAR FROM sale_date) AS year,
		 EXTRACT(MONTH FROM sale_date) AS month,
		 AVG(total_sale) AS avg_sale,
		 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY 1,2
) AS t1
WHERE rank=1;

--- Q8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) AS new_sale 
FROM retail_sales
GROUP BY customer_id
ORDER BY 1
LIMIT 5;

---- Q9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category, COUNT(DISTINCT customer_id) 
FROM retail_sales
GROUP BY category;

--- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
SELECT *,	
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
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

--- END OF QUERY















	 