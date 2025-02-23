-- 1. Retrieve all records from the orders table.--  
SELECT * FROM orders;

-- 2. Get a list of all distinct countries from the customers table.

SELECT DISTINCT Country FROM customers;

-- Find all coffee products with a unit price greater than 10.
 
SELECT `Unit Price` FROM products 
WHERE `Unit Price` > 10;

-- 4. Count the total number of orders.-- 

SELECT count(`Order ID`) as total_orders FROM orders;

-- 5. Find the total sales revenue generated from all orders-- 

SELECT SUM(`Sales`) AS total_sales_revenue FROM products;

-- 6. Get the total number of customers from the United States--

SELECT count(*) FROM customers
where Country = 'United States';  

-- 7.   Find the average unit price of coffee products-- 

SELECT AVG(`Unit Price`) as avg_price FROM products;

-- 8. Retrieve a list of customer names along with their orders--  
SELECT 
    customers.`Customer Name`, orders.Quantity as total_orders
FROM
    customers
        JOIN
    orders ON customers.`Customer ID` = orders.`Customer ID`;

SELECT c.`Customer Name`, o.`Order ID`, o.`Order Date` , o.Quantity as orders
FROM customers c
JOIN orders o ON c.`Customer ID` = o.`Customer ID`;

-- 9. Get a list of product names, their unit price, and the total quantity ordered.
SELECT DISTINCT
    products.`Coffee Type`,
    products.`Unit Price` as total_unit_price,
    SUM(orders.Quantity) as total_qyantity_orderd
FROM
    products
        JOIN
   orders ON products.`Product ID` = orders.`Product ID`
GROUP BY products.`Coffee Type`, products.`Unit Price` 
ORDER BY products.`Unit Price` DESC; 
-- order  according to price

SELECT DISTINCT
    products.`Coffee Type`,
    products.`Unit Price` as total_unit_price,
    SUM(orders.Quantity) as total_qyantity_orderd
FROM
    products
        JOIN
   orders ON products.`Product ID` = orders.`Product ID`
GROUP BY products.`Coffee Type`, products.`Unit Price`
ORDER BY  SUM(orders.Quantity) DESC; 
-- order according to quantity 

-- 10. Show the  countries with the most orders.
SELECT customers.Country , COUNT(orders.Quantity) as total_orders
FROM customers 
JOIN orders ON  customers.`Customer ID` = orders.`Customer ID`
GROUP BY customers.Country
ORDER BY COUNT(orders.Quantity) DESC ;

-- Top 5 cities with the most orders
SELECT customers.City , COUNT(orders.Quantity) as total_orders
FROM customers 
JOIN orders ON  customers.`Customer ID` = orders.`Customer ID`
GROUP BY customers.City
ORDER BY COUNT(orders.Quantity) DESC LIMIT 5;

-- 11. Find the top 3 best-selling coffee types (based on total quantity ordered).
SELECT p.`Coffee Type`, SUM(od.Quantity) AS total_orders
FROM products p
JOIN orders od ON p.`Product ID` = od.`Product ID`
GROUP BY p.`Coffee Type`
ORDER BY total_orders DESC
LIMIT 3;

-- 12. Find customers who have never placed an order.
SELECT customers.`Customer Name`
FROM customers
JOIN orders ON customers.`Customer ID` = orders.`Customer ID`
WHERE orders.`Quantity` IS NULL ;
-- There is no customers who placed any order

-- 13. Identify the most profitable product (based on total sales).
SELECT 
    products.`Coffee Type`,
    SUM(products.`Sales`) AS total_revenue
FROM
    products
GROUP BY products.`Coffee Type`
ORDER BY total_revenue DESC
LIMIT 1;

-- 14. Find the total sales revenue per coffee type.
SELECT 
    products.`Coffee Type`,
    SUM(products.`Sales`) AS total_revenue
FROM
    products
GROUP BY products.`Coffee Type`
ORDER BY total_revenue DESC;

-- 15. Get the customer with the highest number of orders.
SELECT customers.`Customer Name` , sum(orders.`Quantity`) as highest_order
FROM customers
JOIN orders ON customers.`Customer ID` = orders.`Customer ID`
GROUP BY  customers.`Customer Name`
ORDER BY highest_order DESC LIMIT 1;

-- 16. Determine the distribution of orders by Roast type.
SELECT products.`Roast Type` , sum(orders.`Quantity`) as Quantity_orderd
FROM products
JOIN orders ON products.`Product ID` = orders.`Product ID`
GROUP BY  products.`Roast Type`
ORDER BY   Quantity_orderd DESC ;

-- 17. Group the orders by date and calculate the average number of coffee ordered per day.
SELECT 
        orders.`Order Date`, ROUND(AVG(orders.Quantity), 0) AS AVG_quantity
    FROM
        orders
    GROUP BY orders.`Order Date` 
    ORDER BY  AVG_quantity DESC ;

-- 18 .Determine the top 3 most ordered COFFEE types based on revenue.
SELECT 
    products.`Coffee Type`,
    round(SUM(orders.Quantity * products.`Unit Price`), 0 ) AS total_revenue
FROM
    products
        JOIN
    orders ON products.`Product ID` = orders.`Product ID`
GROUP BY products.`Coffee Type`
ORDER BY total_revenue DESC
LIMIT 3;

-- 19. Calculate the percentage contribution of each coffee type to total revenue.
SELECT 
    p.`Coffee Type`, 
    round(SUM(od.Quantity * p.`Unit Price`),0) AS total_revenue,
    round(SUM(od.Quantity * p.`Unit Price`) / 
        (SELECT SUM(od.Quantity * p.`Unit Price`) 
         FROM products p 
         JOIN orders od ON p.`Product ID` = od.`Product ID`) * 100 , 0) AS percentage_contribution
FROM products p
JOIN orders od ON p.`Product ID` = od.`Product ID`
GROUP BY p.`Coffee Type`
ORDER BY total_revenue DESC;

-- 20. Analyze the cumulative revenue generated over time.
SELECT 
    o.`Order Date`, 
    SUM(o.Quantity * p.`Unit Price`) AS daily_revenue,
    round(SUM(SUM(o.Quantity * p.`Unit Price`)) OVER (ORDER BY o.`Order Date`) , 0) AS cumulative_revenue
FROM orders o
JOIN products p ON o.`Product ID` = p.`Product ID`
GROUP BY o.`Order Date`
ORDER BY o.`Order Date`;










