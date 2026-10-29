USE ecommerce_project;

-- 1. Total Revenue
SELECT ROUND(SUM(Revenue), 2) AS total_revenue
FROM cleaned_sales;

-- 2. Total Orders
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_sales;

-- 3. Average Order Value
SELECT ROUND(SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 2) AS average_order_value
FROM cleaned_sales;

-- 4. Total Units Sold
SELECT SUM(Quantity) AS total_units_sold
FROM cleaned_sales;

-- 5. Top 10 Products by Revenue
SELECT StockCode, MAX(Description) AS product, ROUND(SUM(Revenue), 2) AS revenue
FROM cleaned_sales
GROUP BY StockCode
ORDER BY revenue DESC LIMIT 10;

-- 6. Top 3 Products by Revenue
SELECT StockCode, MAX(Description) AS product, SUM(Revenue) AS revenue
FROM cleaned_sales
GROUP BY StockCode
ORDER BY revenue DESC LIMIT 3;

-- 7. Top 10 Products by Quantity
SELECT StockCode, MAX(Description) AS product, SUM(Quantity) AS units_sold
FROM cleaned_sales
GROUP BY StockCode
ORDER BY units_sold DESC LIMIT 10;

-- 8. Revenue by Country
SELECT Country, ROUND(SUM(Revenue), 2) AS revenue
FROM cleaned_sales
GROUP BY Country
ORDER BY revenue DESC;

-- 9. Top 3 Countries by Revenue
SELECT Country, SUM(Revenue) AS revenue
FROM cleaned_sales
GROUP BY Country
ORDER BY revenue DESC LIMIT 3;

-- 10. Total Unique Customers
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM cleaned_sales;

-- 11. Top 10 Customers by Spending
SELECT CustomerID, SUM(Revenue) AS spending
FROM cleaned_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY spending DESC LIMIT 10;

-- 12. Top 3 Customers by Spending
SELECT CustomerID, SUM(Revenue) AS spending
FROM cleaned_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY spending DESC LIMIT 3;

-- 13. Top 3 Customers by Number of Orders
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS orders
FROM cleaned_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY orders DESC LIMIT 3;

-- 14. Customers with More Than 3 Orders
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS orders
FROM cleaned_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
HAVING orders > 3;

-- 15. Top 3 Products by Units Sold
SELECT StockCode, MAX(Description) AS product, SUM(Quantity) AS units_sold
FROM cleaned_sales
GROUP BY StockCode
ORDER BY units_sold DESC LIMIT 3;

-- 16. Top 3 Countries by Units Sold
SELECT Country, SUM(Quantity) AS units_sold
FROM cleaned_sales
GROUP BY Country
ORDER BY units_sold DESC LIMIT 3;

-- 17. Top 3 Orders by Value
SELECT InvoiceNo, SUM(Revenue) AS order_value
FROM cleaned_sales
GROUP BY InvoiceNo
ORDER BY order_value DESC LIMIT 3;

-- 18. Average Spending per Customer
SELECT ROUND(SUM(Revenue) / COUNT(DISTINCT CustomerID), 2) AS avg_spending
FROM cleaned_sales
WHERE CustomerID IS NOT NULL;
