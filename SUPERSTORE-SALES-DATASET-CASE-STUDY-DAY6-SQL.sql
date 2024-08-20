-- USE Superstore


-- Q1 - Retrieve the first 10 rows from the Orders table

SELECT * FROM train
LIMIT 10;

-- Q2 - Retrieve all orders where the Category is 'Furniture'

SELECT * FROM train
WHERE Category = 'Furniture';

-- Q3 - Retrieve orders where the Category is 'Furniture' and Region is 'East'

SELECT * FROM train
WHERE Category = 'Furniture' and Region = 'East';

-- Q4 - Retrieve all orders and sort them by Order Date in descending order

SELECT * FROM train
ORDER BY `Order Date` DESC;

-- Q5 - Find the total number of orders

SELECT COUNT(*) FROM train;

-- Q6 - Find the total number of orders per Region

SELECT Region,COUNT(*) FROM train
GROUP BY Region;

-- Q7 - Calculate the total sales across all orders

SELECT SUM(Sales) FROM train;

-- Q8 - Find regions that have total sales greater than $50,000.

SELECT Region,SUM(Sales) FROM train
GROUP BY Region
HAVING SUM(Sales) > 50000;

-- Q9 - Find the average discount provided in the orders.

SELECT AVG(Dsicount) FROM train;

-- Q10 - Retrieve a list of all orders with the respective customer information (join Orders with Customers).

SELECT Orders.*, Customers.*
FROM Orders
INNER JOIN Customers ON Orders.Customer_ID = Customers.Customer_ID;

-- Q11 -  Retrieve all orders and their respective return information, if any (join Orders with Returns).

SELECT Orders.*, Returns.*
FROM Orders
LEFT JOIN Returns ON Orders.Order_ID = Returns.Order_ID;


-- Q12 - Retrieve all orders placed in the year 2017

SELECT * FROM train
WHERE year(`Order Date`) = 2017;

-- Q13 - Retrieve the total sales for each category and use an alias for the aggregated column

SELECT Category,SUM(Sales) as Sale FROM train
GROUP BY Category;

-- Q14 - Retrieve all orders where the Ship Mode is either 'Second Class' or 'First Class'

SELECT * FROM train
WHERE `Ship Mode` IN ('First Class','Second Class');

-- Q15 - Retrieve a list of all unique customer IDs from the table

SELECT DISTINCT(`Customer ID`) FROM train;

-- Q16 - Create a new column that categorizes sales as 'High' (if Sales > 500), 'Medium' 
-- (if Sales between 100 and 500), and 'Low' (if Sales < 100).

SELECT `Order ID`,`Sales`,
CASE
	WHEN Sales >500 THEN 'HIGH'
	WHEN Sales BETWEEN 100 AND 500 THEN 'MEDIUM'
	WHEN Sales < 100 THEN 'Low'
END AS Sales_category
FROM train;

-- Q17 - Retrieve all orders where the Customer_ID is one of the top 5 customers by total sales

SELECT * FROM train
WHERE `Customer ID` IN(SELECT `Customer ID`,SUM(Sales) Sale FROM train
GROUP BY `Customer ID`
ORDER BY Sale DESC
LIMIT 5);

-- Q18 Combine the results of two queries: Retrieve all customers who ordered 'Furniture' and all customers who ordered 'Technology'.

SELECT * FROM train
WHERE Category = 'Furniture'
UNION
SELECT * FROM train
WHERE Category = 'Technology';


-- Q19 - Retrieve the order with the highest sales.

SELECT * FROM train
WHERE Sales =  (SELECT MAX(Sales) FROM train);

-- Q20 - Assign a row number to each order based on sales, partitioned by Region and ordered by Sales in descending order.

SELECT `Order ID` , Region,Sales,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY Sales DESC) AS ROW_num 
FROM train;

-- Q21 - Rank each order based on sales within each Category.

SELECT `Order ID`,Category,Sales,
RANK() OVER(PARTITION BY Category ORDER BY Sales DESC) AS Rankk
FROM train ;
















