-- Active: 1684692572359@@127.0.0.1@3306@online_retail_star

-- a) Slicing:

-- Slicing involves selecting a specific subset of data based on a condition.

-- Business question: What are the sales transactions specifically from the United Kingdom?

SELECT * FROM fact_sales WHERE country = 'United Kingdom';

-- b) Dicing:

-- Dicing involves selecting a subset of data based on multiple conditions.

-- Business question: What are the sales transactions from the United Kingdom in the year 2022?

SELECT *
FROM fact_sales
WHERE
    country = 'United Kingdom'
    AND YEAR(invoice_date) = 2010;

-- c) Pivoting:

-- Pivoting involves transforming rows into columns to provide a different view of the data.

-- Business question: What is the total sales amount for each year?

SELECT
    YEAR(invoice_date) AS year,
    SUM(total_price) AS total_sales
FROM fact_sales
GROUP BY YEAR(invoice_date);

-- d) Drill down:

-- Drill down involves viewing data at a more detailed level, such as going from year to month.

-- Business question: What is the total sales amount for each year and month?

SELECT
    YEAR(invoice_date) AS year,
    MONTH(invoice_date) AS month,
    SUM(total_price) AS total_sales
FROM fact_sales
GROUP BY
    YEAR(invoice_date),
    MONTH(invoice_date);

-- e) Drill-up:

-- Drill-up involves aggregating data to a higher level, such as going from month to year.

-- Business question: What is the total sales amount for each year, aggregated from monthly data?

SELECT
    YEAR(invoice_date) AS year,
    SUM(total_price) AS total_sales
FROM fact_sales
GROUP BY YEAR(invoice_date);

-- f) Drill across:

-- Drill across involves navigating across different dimensions, such as analyzing sales by country and product.

-- Business question: What are the total sales for each country and product?

SELECT
    DC.country,
    SUM(total_price) AS total_sales
FROM fact_sales FS
    JOIN dim_country DC ON FS.country = DC.country
GROUP BY DC.country;

-- g) Drill through:

-- Drill through involves accessing detailed data by drilling down on a specific dimension.

-- Business question: What are the sales transactions specifically for the product with stock code '85123A'?

SELECT * FROM fact_sales WHERE stock_code = '85123A';