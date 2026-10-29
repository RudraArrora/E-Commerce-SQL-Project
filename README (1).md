# E-Commerce SQL Business Analytics

## Project Objective

I built this project to strengthen my SQL skills and understand how SQL can help business analysts turn raw sales data into useful business information. The focus is on data cleaning, writing practical SQL queries, and understanding sales, products, customers, and business performance.

## Tools and Dataset

- **Tool:** MySQL
- **Dataset:** Online Retail sales transactions
- **Language:** SQL only (no Python or CTEs)

## Data Cleaning

The cleaning process covers:

- Checking missing customer IDs and product descriptions
- Finding empty descriptions and duplicate records
- Identifying invalid quantities and prices
- Checking cancelled transactions
- Creating a cleaned sales table while keeping the original dates unchanged
- Calculating revenue for valid sales
- Validating cleaned records and comparing raw vs. cleaned data

## Business Analysis

SQL queries are used to answer business questions such as:

- Total revenue, orders, and customers
- Sales performance and order value
- Top customers by spending and number of orders
- Customers with more than three orders
- Top products by units sold
- Top countries by units sold
- Highest-value orders
- Average spending per customer

## What I Learned

This project helped me practice SQL for real business questions and see why clean data matters for accurate reporting. It also improved my ability to interpret query results from a business analyst's perspective.

## How to Use

1. Import the Online Retail CSV into MySQL as `raw_sales` in the `ecommerce_project` database.
2. Run the data cleaning SQL to create `cleaned_sales`.
3. Run the business analysis SQL queries on the cleaned data.

The SQL scripts are available in the `sql/` folder.
