-- Total sales per product
SELECT p.ProductName,
       SUM(s.Quantity * p.Price) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;

-- Monthly sales trend
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month,
       SUM(s.Quantity * p.Price) AS Revenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY Month
ORDER BY Month;

-- Top 5 customers by revenue
SELECT c.Name,
       SUM(s.Quantity * p.Price) AS TotalSpent
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY c.Name
ORDER BY TotalSpent DESC
LIMIT 5;

-- Sales ranking per store
SELECT st.StoreName,
       SUM(s.Quantity * p.Price) AS Revenue,
       RANK() OVER (ORDER BY SUM(s.Quantity * p.Price) DESC) AS StoreRank
FROM Sales s
JOIN Stores st ON s.StoreID = st.StoreID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY st.StoreName;

-- Repeat customers (more than 1 purchase)
SELECT CustomerID, COUNT(DISTINCT SaleID) AS PurchaseCount
FROM Sales
GROUP BY CustomerID
HAVING COUNT(DISTINCT SaleID) > 1;
