# SUPERSTORE-SALES-DATASET-CASE-STUDY-DAY6-SQL
SUPERSTORE-SALES-DATASET-CASE-STUDY-DAY6-SQL
# Analysis of Superstore Sales Dataset

This project involves analyzing the Superstore Sales Dataset to uncover insights into sales performance, customer behavior, and regional trends. The analysis aims to provide a comprehensive view of sales dynamics and help make data-driven decisions.

## Table of Contents

- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [SQL Queries](#sql-queries)
- [Key Insights](#key-insights)
- [Tools and Techniques](#tools-and-techniques)
- [Conclusion](#conclusion)
- [Contact](#contact)

## Project Overview

The project explores various aspects of the Superstore Sales Dataset to understand sales patterns, customer segmentation, and regional performance. By analyzing sales data, we aim to identify key trends and factors influencing sales performance.

## Dataset

The dataset used in this analysis includes information on:
- **Order ID**: Unique identifier for each order.
- **Order Date**: Date when the order was placed.
- **Ship Mode**: Shipping method used for the order.
- **Category**: Product category of the order.
- **Region**: Geographical region where the order was placed.
- **Customer ID**: Unique identifier for the customer.
- **Sales**: Total sales amount for the order.
- **Discount**: Discount applied to the order.

## SQL Queries

```sql
-- Retrieve the first 10 rows from the Orders table
SELECT * FROM Orders
LIMIT 10;

-- Retrieve all orders where the Category is 'Furniture'
SELECT * FROM Orders
WHERE Category = 'Furniture';

-- Retrieve orders where the Category is 'Furniture' and Region is 'East'
SELECT * FROM Orders
WHERE Category = 'Furniture' AND Region = 'East';

-- Retrieve all orders and sort them by Order Date in descending order
SELECT * FROM Orders
ORDER BY `Order Date` DESC;

-- Find the total number of orders
SELECT COUNT(*) FROM Orders;

-- Find the total number of orders per Region
SELECT Region, COUNT(*) FROM Orders
GROUP BY Region;

-- Calculate the total sales across all orders
SELECT SUM(Sales) FROM Orders;

-- Find regions that have total sales greater than $50,000
SELECT Region, SUM(Sales) FROM Orders
GROUP BY Region
HAVING SUM(Sales) > 50000;

-- Find the average discount provided in the orders
SELECT AVG(Discount) FROM Orders;

-- Retrieve a list of all orders with the respective customer information (join Orders with Customers)
SELECT Orders.*, Customers.*
FROM Orders
INNER JOIN Customers ON Orders.Customer_ID = Customers.Customer_ID;

-- Retrieve all orders and their respective return information, if any (join Orders with Returns)
SELECT Orders.*, Returns.*
FROM Orders
LEFT JOIN Returns ON Orders.Order_ID = Returns.Order_ID;

-- Retrieve all orders placed in the year 2017
SELECT * FROM Orders
WHERE YEAR(`Order Date`) = 2017;

-- Retrieve the total sales for each category and use an alias for the aggregated column
SELECT Category, SUM(Sales) AS Sale FROM Orders
GROUP BY Category;

-- Retrieve all orders where the Ship Mode is either 'Second Class' or 'First Class'
SELECT * FROM Orders
WHERE `Ship Mode` IN ('First Class', 'Second Class');

-- Retrieve a list of all unique customer IDs from the table
SELECT DISTINCT Customer_ID FROM Orders;

-- Create a new column that categorizes sales as 'High' (if Sales > 500), 'Medium' (if Sales between 100 and 500), and 'Low' (if Sales < 100)
SELECT Order_ID, Sales,
CASE
    WHEN Sales > 500 THEN 'High'
    WHEN Sales BETWEEN 100 AND 500 THEN 'Medium'
    ELSE 'Low'
END AS Sales_Category
FROM Orders;

-- Retrieve all orders where the Customer_ID is one of the top 5 customers by total sales
SELECT * FROM Orders
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM Orders
    GROUP BY Customer_ID
    ORDER BY SUM(Sales) DESC
    LIMIT 5
);

-- Combine the results of two queries: Retrieve all customers who ordered 'Furniture' and all customers who ordered 'Technology'
SELECT * FROM Orders
WHERE Category = 'Furniture'
UNION
SELECT * FROM Orders
WHERE Category = 'Technology';

-- Retrieve the order with the highest sales
SELECT * FROM Orders
WHERE Sales = (SELECT MAX(Sales) FROM Orders);

-- Assign a row number to each order based on sales, partitioned by Region and ordered by Sales in descending order
SELECT Order_ID, Region, Sales,
ROW_NUMBER() OVER (PARTITION BY Region ORDER BY Sales DESC) AS Row_Num
FROM Orders;

-- Rank each order based on sales within each Category
SELECT Order_ID, Category, Sales,
RANK() OVER (PARTITION BY Category ORDER BY Sales DESC) AS Rank
FROM Orders;
