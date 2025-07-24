# SQL Datawarehouse Project

A modern **PostgreSQL-based data warehouse** implemented using the **Medallion Architecture** (Bronze → Silver → Gold). This portfolio project showcases robust data modeling, end-to-end ETL pipelines, quality checks, and analytics-ready transformations — all containerized and version-controlled for reproducibility.

## Overview
This project simulates a real-world retail or CRM data warehouse, built entirely in PostgreSQL. It demonstrates a scalable and modular approach to managing structured data pipelines using:

- **Medallion Architecture** for layer separation
- **Docker** for containerization
- **psql / pgAdmin** for data access
- **Draw.io** for data flow visualization
---
## Data Source:

- Two source systems: **ERP** and **CRM**
- Raw data provided as CSV files
- Ingested into the `bronze` schema for processing
---
## 🚀 Features & Highlights

- **PostgreSQL-based Data Warehouse**: Set up and managed using Docker Compose with persistent volumes for consistent local development and testing.

- **Modular Medallion Architecture**:
  - **Bronze Layer**: Ingests raw data from multiple CSV sources into staging tables.
  - **Silver Layer**: Performs data cleaning, standardization, type enforcement, and deduplication.
  - **Gold Layer**: Creates analytics-ready fact and dimension tables for business intelligence and reporting.

- **SQL-Driven ETL Pipelines**: All transformations are implemented via clean, modular `.sql` scripts to ensure maintainability and transparency.

- **Advanced SQL Transformations**: Leverages `CASE`, `TO_DATE`, `DATE_TRUNC`, `LEAD`, `LAG`, `ROUND`,  `NULLIF` and more for real-world data modeling and enrichment.

- **Business-Focused Analytics**:
  - Customer behavior analysis
  - Product lifecycle and performance
  - Sales trends by month/year
  - Order timelines and churn detection

- **Built-in Data Quality Checks**: Validates schema integrity, null ratios, duplicate detection, and column formatting.

- **Visual Documentation with Draw.io**:
  - Data flow diagrams and integration architecture
  - Editable `.drawio` sources and PNG exports included in `/docs/` folder
---
## 📁 Repository Structure
```bash
├── datasets
│  ├── source_crm
│  │  ├── *.csv
│  └── source_erp
│      ├── *.csv
├── docs
│  ├── *.drawio
│  ├── *.png
│  ├── *.md
├── scripts
│  ├── init_database.sql
│  ├── analytics
│  │  ├── *.sql
│  ├── bronze
│  │  ├── ddl_bronze.sql
│  │  └── load_bronze_data.sql
│  ├── gold
│  │  └── ddl_gold.sql
│  └── silver
│      ├── ddl_silver.sql
│      ├── load_silver_*.sql
└── tests
│  ├── quality_checks_gold
│  │  └── qc_gold.sql
│  └── qualtiy_checks_silver
│  │  ├── qc_silver_*.sql       
├── docker-compose.yml
├── .gitignore
├── LICENSE
└── README.md
```

## Getting Started

### Prerequisites

- Docker & Docker Compose
- (Optional) `psql` CLI installed locally
- PostgreSQL access via Docker (`docker exec`or pgAdmin)

---

### Setup & Run

1. **Clone the repository**:

```bash
git clone https://github.com/jazz-min/sql-datawarehouse-project.git
cd sql-datawarehouse-project
```

2. **Create a .env file**. Replace the sample values with your actual credentials.
```bash
POSTGRES_USER=admin
POSTGRES_PASSWORD=admin123
POSTGRES_DB=DataWarehouse

PGADMIN_DEFAULT_EMAIL=admin@admin.com
PGADMIN_DEFAULT_PASSWORD=admin123 
```

3. **Spin up the containers:**

```bash
docker-compose up -d
```

4. **Initialize schemas and load Bronze data:**
```bash
docker exec -i postgres_db psql -U admin -d postgres < scripts/init_database.sql
docker exec -i postgres_db psql -U admin -d DataWarehouse < scripts/bronze/ddl_bronze.sql
docker exec -i postgres_db psql -U admin -d DataWarehouse < scripts/bronze/load_bronze.sql
```
5. **Apply Silver transformations:**
```bash
docker exec -i postgres_db psql -U admin -d DataWarehouse < scripts/silver/ddl_silver.sql
docker exec -i postgres_db psql -U admin -d DataWarehouse < scripts/silver/load_silver_crm_info.sql
```
Repeat for other Silver layer scripts

6. **Apply  Gold transformations:**
```bash
docker exec -i postgres_db psql -U admin -d DataWarehouse < scripts/gold/ddl_gold.sql

```
7. **Run data quality checks:**
```bash
docker exec -i postgres_db psql -U admin -d DataWarehouse < tests/quality_checks_silver/qc_silver_crm_cust_info.sql
docker exec -i postgres_db psql -U admin -d DataWarehouse < tests/quality_checks_gold/qc_gold.sql
```
Repeat for other Silver layer scripts


---
## 📊 Medallion Architecture Overview

- **Bronze Layer**: Raw ingested data from source files (CSV) into the `bronze.*` schema.
- **Silver Layer**: Cleaned and structured staging tables in the `silver.*` schema.
- **Gold Layer**: Final analytics-ready reporting models in the `gold.*` schema.

---
### 🧮 Analytics Scripts

Analytical queries and insights (e.g. monthly sales trends, customer segmentation, product performance) are available in:
/scripts/analytics/

Run them with:

```bash
docker exec -i postgres_db psql -U admin -d DataWarehouse < scripts/analytics/your_script.sql
```
Replace your_script.sql with the file you want to run. 

Alternatively, use the pgAdmin UI via http://localhost:8081.

### 🧭 Data Flow Diagram

- 📎 ![Data Flow Diagram](docs/data_flow_diagram_sql_dw.png)
- ✏️ Editable source: [`docs/data_flow_diagram_sql_dw.drawio`](docs/data_flow_diagram_sql_dw.drawio)


## Usage

- Run ETL and transformation scripts to populate your data warehouse.
- Execute analytical queries for insights into customer, product, and sales data.

## What I Learned

- How to structure a modular data warehouse using the Medallion Architecture (Bronze → Silver → Gold).
- Writing clean, reusable, and scalable SQL transformation scripts.
- Loading and managing PostgreSQL databases using Docker and pgAdmin.
- Implementing real-world data quality checks (e.g., nulls, type mismatches, duplicates).
- Using advanced SQL functions (`CASE`, `LEAD`, `LAG`, `DATE_TRUNC`, etc.) for time-based and conditional analytics.
- Organizing a data engineering project with version-controlled scripts and documented ETL flows.


## Future Improvements

- Add dbt for automated SQL transformations with dependency management and testing.
- Integrate Apache Airflow for orchestrating the ETL workflow.
- Schedule data refreshes and automate quality checks via cron or Airflow.
- Include unit tests for transformations using `pytest` or `dbt tests`.
- Build interactive dashboards using Apache Superset or Metabase on top of the Gold layer.
- Expand to include real-time or incremental loading mechanisms.


## License

![MIT License](LICENSE)

## 🛠️ Tech Stack & Tools

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=flat&logo=sqlite&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-008BB9?style=flat&logo=postgresql&logoColor=white)
![Draw.io](https://img.shields.io/badge/Draw.io-FF9900?style=flat&logo=diagramsdotnet&logoColor=white)
