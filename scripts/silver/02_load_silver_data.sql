INSERT INTO silver.crm_cust_info
    (
        cst_id            ,
        cst_key           ,
        cst_firstname     ,
        cst_lastname      ,
        cst_marital_status,
        cst_gndr          ,
        cst_create_date
    )
SELECT
    cst_id                                   ,
    cst_key                                  ,
    trim(cst_firstname) AS cst_firstname     ,
    trim(cst_lastname)  AS cst_lastname      ,
    CASE
        WHEN
            UPPER(trim(cst_marital_status)) = 'M'
        THEN 'Married'
        WHEN
            UPPER(trim(cst_marital_status)) = 'S'
        THEN 'Single'
        ELSE 'n/a'
    END                 AS cst_marital_status,
    CASE
        WHEN
            UPPER(trim(cst_gndr)) = 'M'
        THEN 'Male'
        WHEN
            UPPER(trim(cst_gndr)) = 'F'
        THEN 'Female'
        ELSE 'n/a'
    END                 AS cst_gndr          ,
    cst_create_date
FROM
    (
        SELECT
            *,
            row_number() OVER
                (
                    PARTITION BY
                        cst_id
                    ORDER BY
                        cst_create_date DESC
                )
            AS latest_entry
        FROM
            bronze.crm_cust_info )t
WHERE
    latest_entry = 1
---------------------------------------------------
TRUNCATE TABLE silver.crm_prd_info
INSERT INTO silver.crm_prd_info
    (
        prd_id      ,
        cat_id      ,
        prd_key     ,
        prd_nm      ,
        prd_cost    ,
        prd_line    ,
        prd_start_dt,
        prd_end_dt
    )
SELECT
    prd_id                                                          ,
    REPLACE(substring(prd_key,1,5), '-', '_')            AS cat_id  ,
    REPLACE(substring(prd_key,7,LEN(prd_key)), '-', '_') AS prd_key ,
    prd_nm                                                          ,
    ISNULL(prd_cost,0)                                   AS prd_cost,
    CASE
        UPPER(trim(prd_line))
        WHEN
            'M'
        THEN 'Mountain'
        WHEN
            'R'
        THEN 'Road'
        WHEN
            'S'
        THEN 'Other Sales'
        WHEN
            'T'
        THEN 'Touring'
        ELSE 'n/a'
    END                                                  AS prd_line,
    CAST(prd_start_dt AS DATE)                                      ,
    CAST(LEAD(prd_start_dt) OVER
        (
            PARTITION BY
                prd_key
            ORDER BY
                prd_start_dt
        )
    -1 AS DATE)                                          AS prd_end_dt_test
FROM
    bronze.crm_prd_info;
--------------------------------------------
-- crm_sales_details
--------------------------------------------
INSERT INTO silver.crm_sales_details
    (
        sls_ord_num ,
        sls_prd_key ,
        sls_cust_id ,
        sls_order_dt,
        sls_ship_dt ,
        sls_due_dt  ,
        sls_sales   ,
        sls_quantity,
        sls_price
    )
SELECT
    sls_ord_num        ,
    sls_prd_key        ,
    sls_cust_id        ,
    CASE
        WHEN
            sls_order_dt           = 0
            OR LEN(sls_order_dt) ! = 8
        THEN NULL
        ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
    END AS sls_order_dt,
    CASE
        WHEN
            sls_ship_dt           = 0
            OR LEN(sls_ship_dt) ! = 8
        THEN NULL
        ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
    END AS sls_ship_dt ,
    CASE
        WHEN
            sls_due_dt           = 0
            OR LEN(sls_due_dt) ! = 8
        THEN NULL
        ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
    END AS sls_due_dt  ,
    CASE
        WHEN
            sls_sales IS NULL
            OR sls_sales <= 0
            OR sls_sales != sls_quantity * ABS(sls_price)
        THEN sls_quantity * ABS(sls_price)
        ELSE sls_sales
    END AS sls_sales   ,    -- Recalculate sales if original value is missing or incorrect
    sls_quantity       ,
    CASE
        WHEN
            sls_price IS NULL
            OR sls_price <= 0
        THEN sls_sales / NULLIF(sls_quantity,0)
        ELSE sls_price
    END AS sls_price       -- Derive price if original value is invalid
FROM
    bronze.crm_sales_details;

--------------------------------------

insert into silver.erp_cust_az12(
    cid,
    bdate,
    gen
)
select 
    case when cid like 'NAS%' then SUBSTRING(cid,4,LEN(cid))
        else cid
    end cid,
    case when bdate > GETDATE() then null
        else bdate
    end bdate,  -- Set future birthdates to NULL
    case when upper(trim(gen)) in ('F', 'Female') then 'Female'
         when upper(trim(gen)) in ('M', 'Male') then 'Male'
         else 'n/a'
    end as gen  -- Normalize gender values and handle unknown cases
from bronze.erp_cust_az12


----------------------------------------
insert into silver.erp_loc_a101(
    cid,
    cntry
)
select 
    replace(cid,'-','') cid,
    case when UPPER(trim(cntry)) in ('DE','GERMANY') then 'Germany'
         when UPPER(trim(cntry)) in ('US','USA','UNITED STATES') then 'United States'
         when trim(cntry) = '' or cntry is null then 'n/a'
        else trim(cntry)
    end cntry   -- Normalize and Handle missing or blank country codes
from bronze.erp_loc_a101


----------------------------------------