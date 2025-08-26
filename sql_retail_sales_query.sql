SELECT *
FROM retail_sales;

-- How many unique customers in the table
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;

SELECT DISTINCT category
FROM retail_sales;

-- Write an SQL queriy to retrieve all coloums for sales made on '2022-11-05'
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the the category is "clothing" and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'clothing' 
    AND DATE_FORMAT(NOW(), '%Y-%m') 
    AND quantiy >= 4;
    
-- Write a SQL query to calculate the total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_order
FROM retail_sales
GROUP BY 1;

-- Write an SQL query to retrieve the average age of customers who purchased items from the 'beauty' category
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale > '1000';

-- Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month

SELECT 
	`year`,
    `month`,
    avg_sale
 FROM
(
SELECT 
	YEAR(sale_date) AS `year`,
    MONTH(sale_date) AS `month`,
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS `rank`
FROM retail_sales
GROUP BY 1, 2
) AS t1
WHERE `rank` = 1;
-- ORDER BY 1, 3 DESC

-- write a SQL query to find the top 5 customers on the highest total sales

SELECT 
customer_id,
SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- write a SQL query to find the number of unique customers who purchased items from each category

SELECT 
	category,
	COUNT(DISTINCT customer_id) AS uniq_cust
FROM retail_sales
GROUP BY category;

-- write a SQL query to create each shift and number of orders (example morning <= 12, afternoon between 12 and 17, evening > 17)

WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT 
shift,
count(*) AS total_orders
FROM hourly_sale
GROUP BY shift

-- End of project