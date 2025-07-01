
-- ===========================================
-- Script: load_silver_crm_cust_info.sql
-- Layer: Silver (Cleansed)
-- Description:
--     Transforms and loads customer data from the bronze layer
--     into the silver layer after applying data quality checks
--     and standardization logic.
--
-- Source: bronze.crm_cust_info
-- Target: silver.crm_cust_info
-- ===========================================
-- Truncating Table: silver.crm_cust_info';
		TRUNCATE TABLE silver.crm_cust_info;
-- Inserting Data Into: silver.crm_cust_info';
		INSERT INTO silver.crm_cust_info (
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		)
		SELECT
			cst_id,
			TRIM(cst_key) AS cst_key,
			TRIM(cst_firstname) AS cst_firstname,
			TRIM(cst_lastname) AS cst_lastname,
			CASE
				WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
				WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
				ELSE 'Unknown'
			END AS cst_marital_status, -- Normalize marital status values to readable format
			CASE
				WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
				WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
				ELSE 'Unknown'
			END AS cst_gndr, -- Normalize gender values to readable format
			cst_create_date
		FROM (
			SELECT
				*,
				ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
			FROM bronze.crm_cust_info
			WHERE cst_id IS NOT NULL
		) t
		WHERE flag_last = 1;-- Select the most recent record per customer


