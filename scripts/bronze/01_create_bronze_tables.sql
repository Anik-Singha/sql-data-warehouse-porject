/*
==================================================
 Script Name : 01_create_bronze_tables.sql
 Layer       : Bronze
 Database    : bronze
 Purpose     : Create raw CRM and ERP tables
 Author      : Anik Singha
==================================================

 WARNING:
 - Raw tables only
 - No transformations
 - No business logic
==================================================
*/

USE bronze;

-- CRM Tables
CREATE TABLE crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

CREATE TABLE crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

CREATE TABLE crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- ERP Tables
CREATE TABLE erp_loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

CREATE TABLE erp_cust_az12 (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);

CREATE TABLE erp_px_cat_g1v2 (
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);
