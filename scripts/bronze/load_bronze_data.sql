/*
 ======================================================================================================
 Script: load_bronze_data.sql
 Description:
     Loads raw CSV data into bronze layer tables.
     Truncates existing data before loading.
     Source files are mounted via Docker at /csv/.

 Usage:
     Run inside Docker container:
     docker exec -i postgres_db psql -U admin -d DataWarehouse < ./scripts/bronze/load_bronze_data.sql
     Alternatively: run interactively in pgAdmin's Query Tool.
 ========================================================================================================
*/

-- Truncate & Load bronze.crm_cust_info

TRUNCATE TABLE bronze.crm_cust_info;
COPY bronze.crm_cust_info 
FROM '/csv/source_crm/cust_info.csv' 
DELIMITER ',' 
CSV HEADER;
	
-- Truncate & Load bronze.crm_prd_info

TRUNCATE TABLE bronze.crm_prd_info;
COPY bronze.crm_prd_info 
FROM '/csv/source_crm/prd_info.csv' 
DELIMITER ',' 
CSV HEADER;

-- Truncate & Load bronze.crm_sales_details

TRUNCATE TABLE bronze.crm_sales_details;
COPY bronze.crm_sales_details
FROM '/csv/source_crm/sales_details.csv'
DELIMITER ','
CSV HEADER;

-- Truncate & Load bronze.erp_loc_a101

TRUNCATE TABLE bronze.erp_loc_a101;
COPY bronze.erp_loc_a101 
FROM '/csv/source_erp/LOC_A101.csv'
DELIMITER ',' 
CSV HEADER;

-- Truncate & Load bronze.erp_cust_az12

TRUNCATE TABLE bronze.erp_cust_az12;
COPY bronze.erp_cust_az12 
FROM '/csv/source_erp/CUST_AZ12.csv'
DELIMITER ',' 
CSV HEADER;

-- Truncate & Load bronze.erp_px_cat_g1v2;

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
COPY bronze.erp_px_cat_g1v2 
FROM '/csv/source_erp/PX_CAT_G1V2.csv'
DELIMITER ',' 
CSV HEADER;

