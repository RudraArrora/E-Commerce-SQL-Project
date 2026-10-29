USE ecommerce_project;

-- 1. Check missing values
SELECT COUNT(*) AS total_records,
       SUM(CustomerID IS NULL) AS missing_customers,
       SUM(Description IS NULL) AS missing_descriptions
FROM raw_sales;

-- 2. Check empty descriptions
SELECT COUNT(*) AS empty_descriptions
FROM raw_sales
WHERE Description IS NULL OR TRIM(Description) = '';

-- 3. Find duplicate records
SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate,
       UnitPrice, CustomerID, Country, COUNT(*) AS duplicate_count
FROM raw_sales
GROUP BY InvoiceNo, StockCode, Description, Quantity, InvoiceDate,
         UnitPrice, CustomerID, Country
HAVING COUNT(*) > 1;

-- 4. Check invalid quantities and prices
SELECT SUM(Quantity <= 0) AS invalid_quantities,
       SUM(UnitPrice <= 0) AS invalid_prices
FROM raw_sales;

-- 5. Check cancelled transactions
SELECT COUNT(*) AS cancelled_records
FROM raw_sales
WHERE InvoiceNo LIKE 'C%';

-- 6. Create cleaned table (keep original InvoiceDate unchanged)
CREATE TABLE IF NOT EXISTS cleaned_sales AS
SELECT DISTINCT
       TRIM(InvoiceNo) AS InvoiceNo,
       TRIM(StockCode) AS StockCode,
       TRIM(Description) AS Description,
       Quantity, InvoiceDate, UnitPrice,
       NULLIF(TRIM(CustomerID), '') AS CustomerID,
       TRIM(Country) AS Country,
       ROUND(Quantity * UnitPrice, 2) AS Revenue
FROM raw_sales
WHERE InvoiceNo IS NOT NULL
  AND TRIM(InvoiceNo) <> ''
  AND InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0
  AND Description IS NOT NULL
  AND TRIM(Description) <> '';

-- 7. Check cleaned records and revenue
SELECT COUNT(*) AS total_records,
       ROUND(SUM(Revenue), 2) AS total_revenue
FROM cleaned_sales;

-- 8. Count orders and customers
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders,
       COUNT(DISTINCT CustomerID) AS total_customers
FROM cleaned_sales;

-- 9. Validate cleaned data
SELECT SUM(Quantity <= 0) AS invalid_quantities,
       SUM(UnitPrice <= 0) AS invalid_prices,
       SUM(InvoiceNo LIKE 'C%') AS cancelled_records,
       SUM(Description IS NULL OR TRIM(Description) = '') AS missing_descriptions
FROM cleaned_sales;

-- 10. Compare raw and cleaned counts
SELECT (SELECT COUNT(*) FROM raw_sales) AS raw_records,
       (SELECT COUNT(*) FROM cleaned_sales) AS cleaned_records,
       (SELECT COUNT(*) FROM raw_sales) -
       (SELECT COUNT(*) FROM cleaned_sales) AS removed_records;
