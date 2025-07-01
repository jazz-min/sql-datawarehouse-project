
-- ==============================================================
-- Script: load_silver_erp_loc_a101.sql
-- Layer: Silver (Cleansed)
-- Description:
--     Transforms and loads product data from the bronze layer
--     into the silver layer after applying data quality checks
--     and standardization logic.
--
-- Source: bronze.erp_loc_a101
-- Target: silver.erp_loc_a101
-- =============================================================

-- Truncating Table: silver.erp_loc_a101;
		TRUNCATE TABLE silver.erp_loc_a101;
-- Inserting Data Into: silver.erp_loc_a101;
		INSERT INTO silver.erp_loc_a101 (
			cid,
			cntry
		)
		SELECT
			REPLACE(cid, '-', '') AS cid,
			CASE
				WHEN TRIM(cntry) = 'DE' THEN 'Germany'
				WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
				WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'Unknown'
				ELSE TRIM(cntry)
			END AS cntry -- Normalize and Handle missing or blank country codes
		FROM bronze.erp_loc_a101;