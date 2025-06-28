/*
===================================================================
Database and Schema Initialization Script
===================================================================

Purpose:
    This script initializes the PostgreSQL environment by creating 
    a database named 'DataWarehouse'. If a database with this name 
    already exists, it will be dropped and recreated.

    Upon creation, the script also defines three organizational 
    schemas within the database: 'bronze', 'silver', and 'gold'.

Caution:
    Executing this script will irreversibly delete the existing 
    'DataWarehouse' database along with all its data. 
    Ensure that you have appropriate backups before proceeding.
*/

-- Connect to the "postgres" database
\c postgres

-- Terminate active connections to "DataWarehouse"
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'DataWarehouse'
  AND pid <> pg_backend_pid();

-- Drop the database if it exists
DROP DATABASE IF EXISTS "DataWarehouse";

-- Create the new database
CREATE DATABASE "DataWarehouse";

-- Connect to the newly created database
\c "DataWarehouse"

-- Create the schemas
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;

