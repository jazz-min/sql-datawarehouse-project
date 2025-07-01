/*
=========================================================================================
Quality Checks
=========================================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' layer - silver.crm_cust_info table.
    It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer - silver.crm_cust_info table.
    - Investigate and resolve any discrepancies found during the checks.
========================================================================================
*/
-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;

