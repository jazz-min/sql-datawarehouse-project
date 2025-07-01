
-- ==============================================================
-- Script: load_silver_erp_cust_az12.sql
-- Layer: Silver (Cleansed)
-- Description:
--     Transforms and loads product data from the bronze layer
--     into the silver layer after applying data quality checks
--     and standardization logic.
--
-- Source: bronze.erp_cust_az12
-- Target: silver.erp_cust_az12
-- =============================================================
--  Truncating Table: silver.erp_cust_az12;
		TRUNCATE TABLE silver.erp_cust_az12;
--  Inserting Data Into: silver.erp_cust_az12;
		INSERT INTO silver.erp_cust_az12 (
			cid,
			bdate,
			gen
		)
		SELECT
			CASE
				WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid)) -- Remove 'NAS' prefix if present
				ELSE cid
			END AS cid,
			CASE
				WHEN bdate > NOW() THEN NULL
				ELSE bdate
			END AS bdate, -- Set future birthdates to NULL
			CASE
				WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
				WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
				ELSE 'Unknown'
			END AS gen -- Normalize gender values and handle unknown cases
		FROM bronze.erp_cust_az12;