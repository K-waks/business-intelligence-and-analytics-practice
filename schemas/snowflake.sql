-- Active: 1684692572359@@127.0.0.1@3306@online_retail_snowflake

-- Online Retail Database based on the Snowflake Schema

USE online_retail_snowflake;

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
        product_id INT AUTO_INCREMENT PRIMARY KEY,
        stock_code VARCHAR(255),
        description VARCHAR(255),
        category VARCHAR(255) DEFAULT 'Uncategorized',
        supplier VARCHAR(255) DEFAULT 'Unknown'
    );

-- dim_customer

CREATE TABLE
    dim_customer (
        customer_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_name VARCHAR(255),
        country VARCHAR(100),
        segment VARCHAR(255) DEFAULT 'Unspecified',
        loyalty_status VARCHAR(255) DEFAULT 'Not Enrolled'
    );

-- dim_date

CREATE TABLE
    dim_date (
        date_id INT AUTO_INCREMENT PRIMARY KEY,
        invoice_date DATETIME,
        day INT,
        month INT,
        year INT
    );

-- dim_country

CREATE TABLE
    dim_country (
        country_id INT AUTO_INCREMENT PRIMARY KEY,
        country VARCHAR(100)
    );

-- dim_category

CREATE TABLE
    dim_category (
        category_id INT AUTO_INCREMENT PRIMARY KEY,
        category_name VARCHAR(255)
    );

-- dim_supplier

CREATE TABLE
    dim_supplier (
        supplier_id INT AUTO_INCREMENT PRIMARY KEY,
        supplier_name VARCHAR(255)
    );

-- ******************* CREATE FACT TABLES  *******************

-- fact_sales

CREATE TABLE
    fact_sales (
        sales_id INT AUTO_INCREMENT PRIMARY KEY,
        product_id INT,
        customer_id INT,
        date_id INT,
        country_id INT,
        quantity INT,
        unit_price DECIMAL(8, 2),
        total_price DECIMAL(10, 2),
        FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
        FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
        FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
        FOREIGN KEY (country_id) REFERENCES dim_country(country_id)
    );

-- fact_returns

CREATE TABLE
    fact_returns (
        return_id INT AUTO_INCREMENT PRIMARY KEY,
        product_id INT,
        customer_id INT,
        date_id INT,
        country_id INT,
        quantity INT,
        unit_price DECIMAL(8, 2),
        return_price DECIMAL(10, 2),
        FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
        FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
        FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
        FOREIGN KEY (country_id) REFERENCES dim_country(country_id)
    );

-- **************** POPULATE THE DIMENSION TABLES  *******************

-- dim_product

INSERT INTO
    dim_product (
        stock_code,
        description,
        category,
        supplier
    )
SELECT
    DISTINCT stock_code,
    description,
    'Uncategorized',
    'Unknown'
FROM online_retail;

-- dim_customer

INSERT INTO
    dim_customer (
        customer_name,
        country,
        segment,
        loyalty_status
    )
SELECT
    DISTINCT customer_id,
    country,
    'Unspecified',
    'Not Enrolled'
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

-- dim_category

INSERT INTO
    dim_category (category_name)
SELECT DISTINCT category
FROM dim_product;

-- dim_supplier

INSERT INTO
    dim_supplier (supplier_name)
SELECT DISTINCT supplier
FROM dim_product;

-- **************** POPULATE THE FACT TABLES  *******************

-- fact_sales table

INSERT INTO
    fact_sales (
        product_id,
        customer_id,
        date_id,
        country_id,
        quantity,
        unit_price,
        total_price
    )
SELECT
    DP.product_id,
    DC.customer_id,
    DD.date_id,
    DCO.country_id,
    ORT.quantity,
    ORT.unit_price, (ORT.quantity * ORT.unit_price) AS total_price
FROM online_retail ORT
    JOIN dim_product DP ON ORT.stock_code = DP.stock_code
    JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
    JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
    JOIN dim_country DCO ON ORT.country = DCO.country;

-- fact_returns table

INSERT INTO
    fact_returns (
        product_id,
        customer_id,
        date_id,
        country_id,
        quantity,
        unit_price,
        return_price
    )
SELECT
    DP.product_id,
    DC.customer_id,
    DD.date_id,
    DCO.country_id,
    ORT.quantity,
    ORT.unit_price, (ORT.quantity * ORT.unit_price) AS return_price
FROM online_retail ORT
    JOIN dim_product DP ON ORT.stock_code = DP.stock_code
    JOIN dim_customer DC ON ORT.customer_id = DC.customer_id
    JOIN dim_date DD ON ORT.invoice_date = DD.invoice_date
    JOIN dim_country DCO ON ORT.country = DCO.country
WHERE ORT.quantity < 0;