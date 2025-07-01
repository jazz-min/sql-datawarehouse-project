
-- ==============================================================
-- Script: load_silver_erp_px_cat_g1v2.sql
-- Layer: Silver (Cleansed)
-- Description:
--     Transforms and loads product data from the bronze layer
--     into the silver layer after applying data quality checks
--     and standardization logic.
--
-- Source: bronze.erp_px_cat_g1v2
-- Target: silver.erp_px_cat_g1v2
-- =============================================================
--  Truncating Table: silver.erp_px_cat_g1v';
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
-- Inserting Data Into: silver.erp_px_cat_g1v2;
		INSERT INTO silver.erp_px_cat_g1v2 (
			id,
			cat,
			subcat,
			maintenance
		)
		SELECT
			id,
			cat,
			subcat,
			maintenance
		FROM bronze.erp_px_cat_g1v2;
