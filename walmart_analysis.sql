-- Columns for sales made in Branch 'A'
SELECT * 
FROM walmartdata
WHERE BRANCH = 'A' ;

SELECT * 
FROM walmartdata
WHERE BRANCH = 'B' ;

SELECT * 
FROM walmartdata
WHERE BRANCH = 'C' ;

-- Total Sales for each product line
SELECT Product_line, sum(Total) AS total_sales
FROM walmartdata
GROUP BY Product_line;

-- All sales transaction where payment method was 'Cash'
SELECT *
FROM walmartdata
WHERE Payment = 'Cash';

-- Total gross income generated in each city
SELECT City, sum(gross_income) AS total_gross_income
FROM walmartdata
GROUP BY City;

-- Average rating given by customers in each branch
SELECT Branch, avg(Rating) as Average_Rating
FROM walmartdata
GROUP BY Branch;

-- total quantity of each product line sold
SELECT Product_line, sum(Quantity) as Total_Quantity
FROM walmartdata
GROUP BY Product_line;

-- top 5 products by unit price
SELECT Product_line, Unit_price
FROM walmartdata
ORDER BY Unit_price DESC
LIMIT 5;

-- Sales transactions with a gross income greater than 30
SELECT * FROM walmartdata
WHERE gross_income > 30;

-- Retrieve sales transactions that occurred on weekends
SELECT 
    Date, 
    DAYNAME(STR_TO_DATE(Date, '%d/%m/%Y')) AS day_of_week
FROM 
    walmartdata
WHERE 
    DAYNAME(STR_TO_DATE(Date, '%d/%m/%Y')) IN ('Saturday', 'Sunday');

-- the total sales and gross income for each month
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%d/%m/%Y'), '%m-%Y') AS month, 
    SUM(Total) AS total_sales, 
    SUM(gross_income) AS total_gross_income
FROM 
    walmartdata
GROUP BY 
    month
ORDER BY 
    STR_TO_DATE(month, '%m-%Y');

-- Number of sales transactions that occurred after 6 PM
SELECT COUNT(*) AS sales_after_6pm
FROM walmartdata
WHERE TIME(Time) > '18:00:00';

-- Sales transactions that have a higher total than the average total of all transactions
SELECT *
FROM walmartdata
WHERE Total > (SELECT AVG(Total) FROM walmartdata);

-- Cumulative gross income for each branch by date.  
SELECT Branch, Date, 
       SUM(gross_income) OVER (PARTITION BY Branch ORDER BY Date) AS cumulative_gross_income
FROM walmartdata
ORDER BY Branch, Date;

-- Find the total cogs for each customer type in each city
SELECT City, Customer_type, SUM(cogs) AS total_cogs
FROM walmartdata
GROUP BY City, Customer_type;
