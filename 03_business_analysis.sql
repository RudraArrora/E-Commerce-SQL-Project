USE ecommerce_project;

-- 1. Total revenue
SELECT ROUND(SUM(Revenue), 2) AS total_revenue
FROM cleaned_sales;

-- 2. Total orders
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_sales;

-- 3. Average order value
SELECT ROUND(SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 2) AS aov
FROM cleaned_sales;

-- 4. Total units sold
SELECT SUM(Quantity) AS total_units
FROM cleaned_sales;

-- 5. Monthly revenue (InvoiceDate must be DATE or DATETIME)
SELECT YEAR(InvoiceDate) AS sales_year, MONTH(InvoiceDate) AS sales_month,
       ROUND(SUM(Revenue), 2) AS revenue
FROM cleaned_sales
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY sales_year, sales_month;

-- 6. Top 3 products by revenue
SELECT StockCode, MAX(Description) AS product, ROUND(SUM(Revenue), 2) AS revenue
FROM cleaned_sales GROUP BY StockCode ORDER BY revenue DESC LIMIT 3;

-- 7. Bottom 3 products by revenue
SELECT StockCode, MAX(Description) AS product, ROUND(SUM(Revenue), 2) AS revenue
FROM cleaned_sales GROUP BY StockCode ORDER BY revenue ASC LIMIT 3;

-- 8. Product percentage contribution to total revenue
SELECT StockCode, MAX(Description) AS product,
       ROUND(SUM(Revenue) * 100 / (SELECT SUM(Revenue) FROM cleaned_sales), 2) AS revenue_pct
FROM cleaned_sales GROUP BY StockCode ORDER BY revenue_pct DESC;

-- 9. Top 3 customers by spending
SELECT CustomerID, ROUND(SUM(Revenue), 2) AS spending
FROM cleaned_sales WHERE CustomerID IS NOT NULL
GROUP BY CustomerID ORDER BY spending DESC LIMIT 3;

-- 10. Top 3 customers by number of orders
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS orders
FROM cleaned_sales WHERE CustomerID IS NOT NULL
GROUP BY CustomerID ORDER BY orders DESC LIMIT 3;

-- 11. Customers with more than 3 orders
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS orders
FROM cleaned_sales WHERE CustomerID IS NOT NULL
GROUP BY CustomerID HAVING COUNT(DISTINCT InvoiceNo) > 3;

-- 12. Top 3 products by units sold
SELECT StockCode, MAX(Description) AS product, SUM(Quantity) AS units
FROM cleaned_sales GROUP BY StockCode ORDER BY units DESC LIMIT 3;

-- 13. Top 3 countries by units sold
SELECT Country, SUM(Quantity) AS units
FROM cleaned_sales GROUP BY Country ORDER BY units DESC LIMIT 3;

-- 14. Top 3 orders by value
SELECT InvoiceNo, ROUND(SUM(Revenue), 2) AS order_value
FROM cleaned_sales GROUP BY InvoiceNo ORDER BY order_value DESC LIMIT 3;

-- 15. Average spending per customer
SELECT ROUND(SUM(Revenue) / COUNT(DISTINCT CustomerID), 2) AS avg_spending
FROM cleaned_sales WHERE CustomerID IS NOT NULL;

-- 16. Categorize customers by spending (example thresholds)
SELECT CustomerID, SUM(Revenue) AS spending,
       CASE WHEN SUM(Revenue) >= 10000 THEN 'High'
            WHEN SUM(Revenue) >= 5000 THEN 'Medium'
            ELSE 'Low' END AS spending_category
FROM cleaned_sales WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;

-- 17. Top 3 countries by revenue
SELECT Country, ROUND(SUM(Revenue), 2) AS revenue
FROM cleaned_sales GROUP BY Country ORDER BY revenue DESC LIMIT 3;
