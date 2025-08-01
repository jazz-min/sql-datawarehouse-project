
-- ==============================================================
-- Script: load_silver_crm_prd_info.sql
-- Layer: Silver (Cleansed)
-- Description:
--     Transforms and loads product data from the bronze layer
--     into the silver layer after applying data quality checks
--     and standardization logic.
--
-- Source: bronze.crm_prd_info
-- Target: silver.crm_prd_info
-- =============================================================

-- Truncating Table: silver.crm_prd_info;
		TRUNCATE TABLE silver.crm_prd_info;
-- Inserting Data Into: silver.crm_prd_info;
		INSERT INTO silver.crm_prd_info (
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
		)
		SELECT
			prd_id,
			REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- Extract category ID
			SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,        -- Extract product key
			prd_nm,
			COALESCE(prd_cost, 0) AS prd_cost,
			CASE
				WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				ELSE 'Unknown'
			END AS prd_line, -- Map product line codes to descriptive values
			CAST(prd_start_dt AS DATE) AS prd_start_dt,
			CAST(
				LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - INTERVAL '1 day'
				AS DATE
			) AS prd_end_dt -- Calculate end date as one day before the next start date
		FROM bronze.crm_prd_info;