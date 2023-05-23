-- Active: 1684692572359@@127.0.0.1@3306@online_retail_star

-- Online Retail Database based on the Star Schema

USE online_retail_star;

DROP TABLE IF EXISTS fact_sales;

DROP TABLE IF EXISTS dim_product;

DROP TABLE IF EXISTS dim_customer;

DROP TABLE IF EXISTS dim_date;

DROP TABLE IF EXISTS dim_country;

DROP TABLE IF EXISTS online_retail;

-- ************************ LOAD THE DATASET **************************

CREATE TABLE
    online_retail (
        invoice_no VARCHAR(100),
        stock_code VARCHAR(255),
        description VARCHAR(255),
        quantity INT,
        invoice_date DATETIME,
        unit_price DECIMAL(8, 2),
        customer_id VARCHAR(100),
        country VARCHAR(100)
    );

LOAD DATA
    INFILE '/var/lib/mysql-files/online_retail.csv' INTO
TABLE
    online_retail FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES(
        invoice_no,
        stock_code,
        description,
        quantity,
        @invoice_date,
        unit_price,
        customer_id,
        country
    )
SET
    invoice_date = STR_TO_DATE(
        @invoice_date,
        '%d/%m/%Y %H:%i'
    );

-- **************** CREATE DIMENSION TABLES  *******************

-- dim_product

CREATE TABLE
    dim_product (
        stock_code VARCHAR(255) PRIMARY KEY,
        description VARCHAR(255)
    );

-- dim_customer

CREATE TABLE
    dim_customer (
        customer_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_name VARCHAR(255),
        country VARCHAR(100)
    );

-- dim_date

CREATE TABLE
    dim_date (
        invoice_date DATETIME PRIMARY KEY,
        day INT,
        month INT,
        year INT
    );

-- dim_country

CREATE TABLE
    dim_country (
        country VARCHAR(100) PRIMARY KEY
    );

-- ******************* CREATE FACT TABLE  *******************

CREATE TABLE
    fact_sales (
        fact_id INT AUTO_INCREMENT PRIMARY KEY,
        stock_code VARCHAR(255),
        customer_id INT,
        invoice_date DATETIME,
        country VARCHAR(100),
        total_price DECIMAL(10, 2),
        FOREIGN KEY (stock_code) REFERENCES dim_product(stock_code),
        FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
        FOREIGN KEY (invoice_date) REFERENCES dim_date(invoice_date),
        FOREIGN KEY (country) REFERENCES dim_country(country)
    );

-- **************** POPULATE THE DIMENSION TABLES  *******************

-- dim_product

INSERT INTO
    dim_product (stock_code, description)
SELECT
    DISTINCT stock_code,
    description
FROM online_retail;

-- dim_customer

INSERT INTO
    dim_customer (customer_name, country)
SELECT
    DISTINCT customer_id,
    country
FROM online_retail;

-- dim_date

INSERT INTO
    dim_date (invoice_date, day, month, year)
SELECT
    DISTINCT invoice_date,
    DAY(invoice_date),
    MONTH(invoice_date),
    YEAR(invoice_date)
FROM online_retail;

-- dim_country

INSERT INTO
    dim_country (country)
SELECT DISTINCT country
FROM online_retail;

-- **************** POPULATE THE FACT TABLE  *******************

-- fact_sales

-- INSERT INTO
--     fact_sales (
--         stock_code,
--         customer_id,
--         invoice_date,
--         country,
--         total_price
--     )
-- SELECT
--     ORT.stock_code,
--     DC.customer_id,
--     ORT.invoice_date,
--     ORT.country, (ORT.quantity * ORT.unit_price) AS total_price
-- FROM online_retail ORT
--     JOIN dim_product DP ON ORT.stock_code = DP.stock_code
--     JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
--     JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
--     JOIN dim_country DCO ON ORT.country = DCO.country;

-- Left Join

INSERT INTO
    fact_sales (
        stock_code,
        customer_id,
        invoice_date,
        country,
        total_price
    )
SELECT
    ORT.stock_code,
    DC.customer_id,
    ORT.invoice_date,
    ORT.country, (ORT.quantity * ORT.unit_price) AS total_price
FROM online_retail ORT
    LEFT JOIN dim_product DP ON ORT.stock_code = DP.stock_code
    LEFT JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
    LEFT JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
    LEFT JOIN dim_country DCO ON ORT.country = DCO.country;

-- Right Join

-- INSERT INTO
--     fact_sales (
--         stock_code,
--         customer_id,
--         invoice_date,
--         country,
--         total_price
--     )
-- SELECT
--     ORT.stock_code,
--     DC.customer_id,
--     ORT.invoice_date,
--     ORT.country, (ORT.quantity * ORT.unit_price) AS total_price
-- FROM online_retail ORT
--     RIGHT JOIN dim_product DP ON ORT.stock_code = DP.stock_code
--     RIGHT JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
--     RIGHT JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
--     RIGHT JOIN dim_country DCO ON ORT.country = DCO.country;

-- -- Full Outer Join (MySQL doesn't have a built-in full outer join, so we can simulate it using a union of left and right joins)

-- INSERT INTO
--     fact_sales (
--         stock_code,
--         customer_id,
--         invoice_date,
--         country,
--         total_price
--     )
-- SELECT
--     ORT.stock_code,
--     DC.customer_id,
--     ORT.invoice_date,
--     ORT.country, (ORT.quantity * ORT.unit_price) AS total_price
-- FROM online_retail ORT
--     LEFT JOIN dim_product DP ON ORT.stock_code = DP.stock_code
--     LEFT JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
--     LEFT JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
--     LEFT JOIN dim_country DCO ON ORT.country = DCO.country
-- UNION
-- SELECT
--     ORT.stock_code,
--     DC.customer_id,
--     ORT.invoice_date,
--     ORT.country, (ORT.quantity * ORT.unit_price) AS total_price
-- FROM online_retail ORT
--     RIGHT JOIN dim_product DP ON ORT.stock_code = DP.stock_code
--     RIGHT JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
--     RIGHT JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
--     RIGHT JOIN dim_country DCO ON ORT.country = DCO.country;