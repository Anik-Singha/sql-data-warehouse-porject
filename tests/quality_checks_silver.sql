/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'bronze' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage:
    - Run these checks to fix any errors before loading the data into the 'silver' layer.
*/


-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for Nulls or Duplicats in Primary Key
-- Expectation : No Nulls or Duplicates
SELECT
    cst_id,
    COUNT(*)
FROM
    bronze.crm_cust_info
GROUP BY
    cst_id
HAVING
    COUNT(*) > 1
OR  cst_id IS NULL;
-- Check for unwanted spaces
-- Expectation : No spaces
SELECT
    cst_firstname
FROM
    bronze.crm_cust_info
WHERE
    cst_firstname != trim(cst_firstname);
SELECT
    cst_lastname
FROM
    bronze.crm_cust_info
WHERE
    cst_lastname != trim(cst_lastname);
-- Check for data consistency & standardization
SELECT DISTINCT
    cst_gndr
FROM
    bronze.crm_cust_info;
SELECT DISTINCT
    cst_marital_status
FROM
    bronze.crm_cust_info;
--------------------------------------------------
-- Inspect bronze.crm_prd_info
--------------------------------------------------
SELECT
    *
FROM
    bronze.crm_prd_info;
-- Check for Nulls or Duplicats in Primary Key
-- Expectation : No Nulls or Duplicates
SELECT
    prd_id,
    COUNT(*)
FROM
    bronze.crm_prd_info
GROUP BY
    prd_id
HAVING
    COUNT(*) > 1
OR  prd_id IS NULL;
/* is is ok */
-- Check for unwanted spaces
-- Expectation : No spaces
SELECT
    prd_nm
FROM
    bronze.crm_prd_info
WHERE
    prd_nm != trim(prd_nm);
-- Check for NULLS or Negative numbers
-- Expectation : No Results
SELECT
    prd_cost
FROM
    bronze.crm_prd_info
WHERE
    prd_cost < 0
OR  prd_cost IS NULL
-- Data Standardization & Consistency
SELECT DISTINCT
    prd_line
FROM
    bronze.crm_prd_info
-- Check for Invalid Date Orders
-- End Dates must not be earlier than Start Dates
SELECT
    *
FROM
    bronze.crm_prd_info
WHERE
    prd_end_dt < prd_start_dt
-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================
-- bronze.crm_sales_details
-- Check for invalid dates
SELECT
    sls_order_dt
FROM
    bronze.crm_sales_details
WHERE
    sls_order_dt <= 0
OR  sls_order_dt IS NULL
OR  LEN(sls_order_dt) != 8
-- Check Data Consistency: Between Sales, Quantity and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative.
SELECT DISTINCT
    sls_sales AS old_sls_sales,
    sls_quantity              ,
    sls_price AS old_sls_price,
    CASE
        WHEN
            sls_sales IS NULL
            OR sls_sales <= 0
            OR sls_sales != sls_quantity * ABS(sls_price)
        THEN sls_quantity * ABS(sls_price)
        ELSE sls_sales
    END       AS sls_sales    ,
    CASE
        WHEN
            sls_price IS NULL
            OR sls_price <= 0
        THEN sls_sales / NULLIF(sls_quantity,0)
        ELSE sls_price
    END       AS sls_price
FROM
    bronze.crm_sales_details
WHERE
    sls_sales    != sls_quantity * sls_price
OR  sls_sales    <= 0
OR  sls_quantity <= 0
OR  sls_price    <= 0
OR  sls_sales IS NULL
OR  sls_quantity IS NULL
OR  sls_price IS NULL
ORDER BY
    sls_sales   ,
    sls_quantity,
    sls_price
----------------------------------------
-- erp_cust_az12
----------------------------------------
-- Identify Out-of_Range Dates
SELECT DISTINCT
    bdate
FROM
    bronze.erp_cust_az12
WHERE
    bdate < '1926-01-01'
OR  bdate > GETDATE()
SELECT
    *
FROM
    bronze.erp_cust_az12
-- Data Standardization & Consistency
SELECT DISTINCT
    gen
FROM
    bronze.erp_cust_az12
----------------------------------------
-- erp_loc_a101
----------------------------------------
-- Data Standardization & Consistency
SELECT DISTINCT
    cntry
FROM
    bronze.erp_loc_a101
---------------------------------------
-- erp_px_cat_g1v2
---------------------------------------
-- Check for unwanted Spaces
SELECT
    *
FROM
    bronze.erp_px_cat_g1v2
WHERE
    cat         != trim(cat)
OR  subcat      != trim(subcat)
OR  maintenance != trim(maintenance)
-- Data Standardization & Consistency
SELECT DISTINCT
    subcat -- check for cat too
FROM bronze.erp_px_cat_g1v2