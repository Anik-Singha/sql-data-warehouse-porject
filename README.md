# Data Warehouse and Analytics Project 🚀

Welcome to the **Data Warehouse and Analytics Project** repository! This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

---

## 🏗️ Data Architecture

The data architecture for this project follows the **Medallion Architecture** (Bronze, Silver, and Gold layers):

* **Bronze Layer:** Stores raw data as-is from the source systems. Data is ingested from CSV Files into a SQL Server Database.
* **Silver Layer:** This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
* **Gold Layer:** Houses business-ready data modeled into a **Star Schema** required for reporting and analytics.

---

## 📖 Project Overview

This project covers the end-to-end lifecycle of data engineering:

1.  **Data Architecture:** Designing a Modern Data Warehouse using Medallion Architecture.
2.  **ETL Pipelines:** Extracting, transforming, and loading data from source systems (ERP/CRM).
3.  **Data Modeling:** Developing Fact and Dimension tables optimized for analytical queries.
4.  **Analytics & Reporting:** Creating SQL-based reports and dashboards for actionable insights.

> [!TIP]
> This repository is an excellent resource for showcasing expertise in **SQL Development, Data Engineering, ETL Pipeline Development, and Data Modeling.**

---

## 🛠️ Tools & Resources

Everything used in this project is **Free**:

| Tool | Purpose |
| :--- | :--- |
| **SQL Server Express** | Lightweight server for hosting the database |
| **SSMS** | GUI for managing and interacting with SQL |
| **Git/GitHub** | Version control and collaboration |
| **Draw.io** | Designing data architecture and star schemas |
| **Notion** | Project management and task tracking |

* **Datasets:** [Link to CSV Files](#)
* **Project Template:** [Notion Link](#)

---

## 🚀 Project Requirements

### 1. Building the Data Warehouse (Data Engineering)
**Objective:** Develop a modern data warehouse using SQL Server to consolidate sales data.
* **Data Sources:** Import data from ERP and CRM systems.
* **Data Quality:** Cleanse and resolve data quality issues (Silver Layer).
* **Integration:** Combine sources into a single, user-friendly Star Schema (Gold Layer).
* **Documentation:** Provide a clear data model for stakeholders.



### 2. BI & Analytics (Data Analysis)
**Objective:** Develop SQL-based analytics to deliver insights into:
* **Customer Behavior** (Segmentation, Lifetime Value)
* **Product Performance** (Top sellers, Category trends)
* **Sales Trends** (MoM Growth, Seasonal patterns)

---

## 📂 Repository Structure

```text
data-warehouse-project/
├── datasets/               # Raw datasets (ERP and CRM data)
├── docs/                   # Architecture, Data Flow, and Data Models
├── scripts/                # SQL scripts for ETL
│   ├── bronze/             # Raw data loading
│   ├── silver/             # Cleaning and transformation
│   ├── gold/               # Analytical modeling (Fact/Dim)
├── tests/                  # Data quality check scripts
└── README.md               # Project overview
```
