use Company
SELECT * FROM Employees ;
--Find the total salary of all employees 
SELECT SUM(Salary) AS TotalSalary
FROM Employees;
--Find the average salary 
SELECT AVG(Salary) AS AverageSalary
FROM Employees;
-- Find the highest salary 
SELECT max(Salary) AS MaxSalary
FROM Employees;
--Find the lowest salary 
SELECT min(Salary) AS MinSalary
FROM Employees;
--Count the total number of employees 
SELECT COUNT(Ssn) AS TotalEmployees
FROM Employees;
-- GROUP BY with Departments
--Show total salary per department 
SELECT SUM(Salary) AS TotalSalary, Dnum
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
--Show average salary per department 
SELECT AVG (Salary) AS AverageSalary, Dnum
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
-- Show number of employees in each department 
SELECT COUNT(Ssn) AS TotalEmployees, Dnum
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;

-- HAVING Clause Filtering 
--Show departments where total salary is greater than 10000
SELECT Dnum, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Dnum
HAVING SUM(Salary) > 1000
ORDER BY Dnum;
-- Show departments with more than 5 employees 
SELECT Dnum, COUNT(Ssn) AS TotalEmployees
FROM Employees
GROUP BY Dnum
HAVING COUNT(Ssn) > 2
ORDER BY Dnum;
--Show departments where average salary is above 5000 
SELECT Dnum, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Dnum
HAVING AVG(Salary) > 1000
ORDER BY Dnum;
-- Orders Analysis 
use JOINING
SELECT * FROM Orders ;
UPDATE Orders
SET Amount = 50
WHERE OrderID = 1;
UPDATE Orders
SET Amount = 100
WHERE OrderID = 2;

UPDATE Orders
SET Amount = 75
WHERE OrderID = 3;
UPDATE Orders
SET Amount = 120
WHERE OrderID = 4;
SELECT * FROM Orders ;
--Find total revenue from all orders  
SELECT SUM(Amount) AS TotalRevenue
FROM Orders;
--Find average order amount 
SELECT AVG(Amount) AS AverageAmount
FROM Orders;
--Count total orders 
SELECT COUNT(OrderID) AS TotalOrders
FROM Orders;
--Find maximum and minimum order amount 
SELECT 
MAX(Amount) AS MaxAmount,
MIN(Amount) AS MinAmount
FROM Orders;
--Show total amount per customer - used group by
SELECT 
CustomerID,
SUM(Amount) AS TotalAmount
FROM Orders
GROUP BY CustomerID
ORDER BY CustomerID;
-- 
SELECT * FROM Orders ;
SELECT * FROM Customers
--. Show number of orders per customer
SELECT 
Customers.CustomerID,
Customers.CustomerName,
COUNT(Orders.OrderID) AS TotalOrders

FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
ORDER BY Customers.CustomerID;
--Show total amount spent per customer
SELECT 
Customers.CustomerID,
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpent
--Show customers who spent more than 1000 total 
SELECT 
Customers.CustomerID,
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpent

FROM Customers

LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
HAVING SUM(Orders.Amount) > 1000
ORDER BY Customers.CustomerID;

--Show customers with no orders
SELECT 
Customers.CustomerID,
Customers.CustomerName
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

-- Sales Performance
SELECT * FROM Sales10 ;
ALTER TABLE Sales10
ADD Price DECIMAL(10,2);
UPDATE Sales10
SET Price = 20
WHERE SaleID = 4;

UPDATE Sales10
SET Price = 15
WHERE SaleID = 5;
UPDATE Sales10
SET Price = 30
WHERE SaleID = 6;
--Find total sales revenue (Quantity × Price) 
SELECT SUM(SoldQty * Price) AS TotalRevenue
FROM Sales10;
--Total quantity sold per product
SELECT 
ProductID,
SUM(SoldQty) AS TotalQuantity
FROM Sales10
GROUP BY ProductID
ORDER BY ProductID;
--Average price per product
SELECT 
ProductID,
AVG(Price) AS AveragePrice
FROM Sales10
GROUP BY ProductID
ORDER BY ProductID;

--Best-selling product
SELECT TOP 1
ProductID,
SUM(SoldQty) AS TotalSold
FROM Sales10
GROUP BY ProductID
ORDER BY TotalSold DESC;
-- Mixed Aggregation Challenge
SELECT * FROM OrderDetails ;
SELECT * FROM Products;
DELETE FROM OrderDetails;
INSERT INTO OrderDetails
(OrderID, ProductID, Quantity)
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 5),
(3, 4, 3),
(3, 1, 4);
--Show total quantity sold per product name 
SELECT 
Products.ProductName,
SUM(OrderDetails.Quantity) AS TotalQuantity

FROM OrderDetails
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY Products.ProductName;

--Show products with total quantity greater than 5 
SELECT 
Products.ProductName,
SUM(OrderDetails.Quantity) AS TotalQuantity

FROM OrderDetails

INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName

-- Show number of orders per product  
SELECT 
Products.ProductName,
COUNT(OrderDetails.OrderID) AS TotalOrders

FROM OrderDetails

INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalOrders DESC ;

--Find the most ordered product
SELECT TOP 1
Products.ProductName,
SUM(OrderDetails.Quantity) AS TotalQuantity

FROM OrderDetails
INNER JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantity DESC;

-- Department Salary Statistics
use Company
SELECT * FROM Employees ;
--Show maximum salary per department 
SELECT 
Dnum,
MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;

--Minimum salary per department
SELECT 
Dnum,
MIN(Salary) AS MinSalary
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
--Average salary per departmen
SELECT 
Dnum,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;

--Salary difference (MAX - MIN)
SELECT 
Dnum,
MAX(Salary) AS MaxSalary,
MIN(Salary) AS MinSalary,
MAX(Salary) - MIN(Salary) AS SalaryDifference

FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
--Employee Performance Analysis
-- Show departments where average salary is above 1000 
SELECT 
Dnum,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Dnum
HAVING AVG(Salary) > 1000
ORDER BY AverageSalary DESC;

--Departments where total salary > 20000
SELECT 
Dnum,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Dnum
HAVING SUM(Salary) > 1000
ORDER BY TotalSalary DESC;
--Departments with more than 2 employees
SELECT 
Dnum,
COUNT(Ssn) AS TotalEmployees
FROM Employees
GROUP BY Dnum
HAVING COUNT(Ssn) > 2
ORDER BY TotalEmployees DESC;

--sort results by highest average salary
SELECT 
Dnum,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Dnum
ORDER BY AverageSalary DESC;

---Customer Spending Report
use JOINING
SELECT * FROM Customers ;
SELECT * FROM Orders ;
--Show total spending per customer
SELECT 
Customers.CustomerID,
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpending

FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
ORDER BY TotalSpending DESC;
--Show average order value per customer 
SELECT 
Customers.CustomerID,
Customers.CustomerName,
AVG(Orders.Amount) AS AverageOrderValue

FROM Customers

LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
ORDER BY AverageOrderValue DESC;
-- Show number of orders per customer  
SELECT 
Customers.CustomerID,
Customers.CustomerName,
COUNT(Orders.OrderID) AS TotalOrders

FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
ORDER BY TotalOrders DESC;
--Show only customers who spent more than 500 
SELECT 
Customers.CustomerID,
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpending

FROM Customers

LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName
HAVING SUM(Orders.Amount) > 100
ORDER BY TotalSpending DESC;

---Product Sales Summary
SELECT * FROM Sales10 ;
--Calculate total revenue per product 
SELECT 
ProductID,
SUM(SoldQty * Price) AS TotalRevenue
FROM Sales10
GROUP BY ProductID
ORDER BY ProductID;
--Find total quantity sold per product 
SELECT 
ProductID,
SUM(SoldQty) AS TotalQuantity
FROM Sales10
GROUP BY ProductID
ORDER BY ProductID;
--Find average price per product
SELECT 
ProductID,
AVG(Price) AS AveragePrice
FROM Sales10
GROUP BY ProductID
ORDER BY ProductID;

--Show products where revenue > 100
SELECT 
ProductID,
SUM(SoldQty * Price) AS TotalRevenue
FROM Sales10
GROUP BY ProductID
HAVING SUM(SoldQty * Price) > 100
ORDER BY TotalRevenue DESC;

-- Order Analysis with Aggregation 
SELECT * FROM Orders ;
--Find total number of orders
SELECT COUNT(OrderID) AS TotalOrders
FROM Orders;
--Find total revenue
SELECT SUM(Amount) AS TotalRevenue
FROM Orders;
--Find average order amount
SELECT AVG(Amount) AS AverageAmount
FROM Orders;
--Find highest and lowest order amount
SELECT 
MAX(Amount) AS HighestAmount,
MIN(Amount) AS LowestAmount
FROM Orders;
--Show customers with more than or equal 2 orders
SELECT 
CustomerID,
COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) >= 2
ORDER BY TotalOrders DESC;

-- Group + Join Challenge
SELECT * FROM Orders ;
SELECT * FROM Customers ;
--Show total orders per customer name  
SELECT 
Customers.CustomerName,
COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalOrders DESC;
--Show total spending per customer name 
SELECT 
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpending
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalSpending DESC;

--Show only customers with spending above 100
SELECT 
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpending
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING SUM(Orders.Amount) > 100
ORDER BY TotalSpending DESC;
--Sort by highest spending
SELECT 
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpending
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalSpending DESC;

--Advanced HAVING Practice
use Company
SELECT * FROM Employees ;
--Show departments where MAX salary > 1500 
SELECT 
Dnum,
MAx(Salary) AS MaxSalary
FROM Employees
GROUP BY Dnum
HAVING MAX(Salary) > 1500;
--Departments where MIN salary < 1200
SELECT 
Dnum,
MIN(Salary) AS MinSalary
FROM Employees
GROUP BY Dnum
HAVING MIN(Salary) < 1200;
--Departments where AVG salary between 1000 and 1500
SELECT 
Dnum,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Dnum
HAVING AVG(Salary) BETWEEN 1000 AND 1500;
--Departments with more than  or equal 2 employees
SELECT 
Dnum,
COUNT(Ssn) AS TotalEmployees
FROM Employees
GROUP BY Dnum
HAVING COUNT(Ssn) >= 2;

-- Real Business Scenario
use JOINING
SELECT * FROM Sales10 ;
SELECT * FROM Products ;
--Show total revenue per product name 
SELECT 
Products.ProductName,
SUM(Sales10.SoldQty * Sales10.Price) AS TotalRevenue

FROM Products
LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Products.ProductName
ORDER BY TotalRevenue DESC;
--Show bestselling product (by quantity)
SELECT 
Products.ProductName,
SUM(Sales10.SoldQty) AS TotalSold

FROM Products
LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSold DESC;
--Show most profitable product (by revenue)
SELECT 
Products.ProductName,
SUM(Sales10.SoldQty * Sales10.Price) AS TotalRevenue

FROM Products
LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Products.ProductName
ORDER BY TotalRevenue DESC;
--Show products with no sales
SELECT 
Products.ProductName
FROM Products
LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
WHERE Sales10.SaleID IS NULL;

-- Multi-Level Aggregation 
use Company
SELECT * FROM Employees ;
--Show total salary per departm
SELECT 
Dnum,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
--Show average salary per department
SELECT 
Dnum,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
--Show departments where total salary is above the overall average department 
SELECT 
Dnum,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Dnum
HAVING SUM(Salary) >
(
    SELECT AVG(Salary)
    FROM Employees
)
ORDER BY TotalSalary DESC;
--Rank departments by total salary (conceptually) 
SELECT 
Dnum,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Dnum
ORDER BY TotalSalary DESC;

-- Sales Time Analysis
use JOINING
SELECT * FROM Sales10 ;
ALTER TABLE Sales10
ADD SaleDate DATE;
UPDATE Sales10
SET SaleDate = '2026-05-01'
WHERE SaleID = 4;
UPDATE Sales10
SET SaleDate = '2026-05-02'
WHERE SaleID = 5;
UPDATE Sales10
SET SaleDate = '2026-05-02'
WHERE SaleID = 6;
--Show total revenue per day  
SELECT 
SaleDate,
SUM(SoldQty * Price) AS TotalRevenue
FROM Sales10
GROUP BY SaleDate
ORDER BY SaleDate;
--Show total revenue per month
SELECT 
MONTH(SaleDate) AS SaleMonth,
SUM(SoldQty * Price) AS TotalRevenue
FROM Sales10
GROUP BY MONTH(SaleDate)
ORDER BY SaleMonth;
--Find the day with highest sales revenue
SELECT TOP 1
SaleDate,
SUM(SoldQty * Price) AS TotalRevenue
FROM Sales10
GROUP BY SaleDate
ORDER BY TotalRevenue DESC;
--Count number of sales per month
SELECT 
MONTH(SaleDate) AS SaleMonth,
COUNT(SaleID) AS TotalSales
FROM Sales10
GROUP BY MONTH(SaleDate)
ORDER BY SaleMonth;

-- Customer Loyalty Analysis
use JOINING
SELECT * FROM Customers ;
SELECT * FROM Orders ;
-- Show customers with more than 1 orders 
SELECT 
Customers.CustomerName,
COUNT(Orders.OrderID) AS TotalOrders

FROM Customers

LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING COUNT(Orders.OrderID) > 1
ORDER BY TotalOrders DESC;
--Show customers whose average order value is above 20 
SELECT 
Customers.CustomerName,
AVG(Orders.Amount) AS AverageOrder
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING AVG(Orders.Amount) > 20
ORDER BY AverageOrder DESC;
--Show top 3 customers by total spending  
SELECT TOP 3
Customers.CustomerName,
SUM(Orders.Amount) AS TotalSpending
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalSpending DESC;
--Find customers who placed only one order 
SELECT 
Customers.CustomerName,
COUNT(Orders.OrderID) AS TotalOrders

FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING COUNT(Orders.OrderID) = 1;

--: Product Category Performance
SELECT * FROM Products ;
SELECT * FROM Sales ;
ALTER TABLE Products
ADD CategoryID INT;
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(30)
);
ALTER TABLE Products
ADD FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);
INSERT INTO Categories (CategoryName)
VALUES
('Electronics'),
('Accessories');
UPDATE Products
SET CategoryID = 1
WHERE ProductID IN (1,2);
UPDATE Products
SET CategoryID = 2
WHERE ProductID IN (3,4);
--Show total revenue per category 
SELECT 
Categories.CategoryName,
SUM(Sales10.SoldQty * Sales10.Price) AS TotalRevenue

FROM Categories

LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID
LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Categories.CategoryName
ORDER BY TotalRevenue DESC;
-- Show average product revenue per category 
SELECT 
Categories.CategoryName,
AVG(Sales10.SoldQty * Sales10.Price) AS AverageRevenue

FROM Categories

LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID

LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Categories.CategoryName
ORDER BY AverageRevenue DESC;
--Show categories with revenue > 100
SELECT 
Categories.CategoryName,
SUM(Sales10.SoldQty * Sales10.Price) AS TotalRevenue

FROM Categories

LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID

LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Categories.CategoryName
HAVING SUM(Sales10.SoldQty * Sales10.Price) > 100;
-- Show best category by total sales  
SELECT TOP 1
Categories.CategoryName,
SUM(Sales10.SoldQty) AS TotalSales

FROM Categories

LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID
LEFT JOIN Sales10
ON Products.ProductID = Sales10.ProductID
GROUP BY Categories.CategoryName
ORDER BY TotalSales DESC;

-- Null Handling in Aggregation
use Company
SELECT * FROM Employees ;
--Count employees with non-null salary  
SELECT 
COUNT(Salary) AS EmployeesWithSalary
FROM Employees;
--Show departments including those with NULL salaries 
SELECT 
Dnum,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Dnum
ORDER BY Dnum;
--Calculate average salary ignoring NULL values 
--Automativ ignore null
SELECT 
AVG(Salary) AS AverageSalary
FROM Employees;
--Show departments where all salaries are NULL
SELECT 
Dnum
FROM Employees
GROUP BY Dnum
HAVING COUNT(Salary) = 0;