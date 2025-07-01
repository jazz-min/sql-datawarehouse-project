
/*
=========================================================================================
Quality Checks
=========================================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' layer - silver.erp_cust_az12 table.
    It includes checks for, as applicable:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer - silver.erp_cust_az12 table.
    - Investigate and resolve any discrepancies found during the checks.
========================================================================================
*/
-- ====================================================================
-- Checking 'silver.erp_cust_az12'
-- ====================================================================
-- Identify Out-of-Range Dates
-- Expectation: No future Dates
SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate > NOW();

-- Data Standardization & Consistency
SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;