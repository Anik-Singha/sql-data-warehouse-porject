# 🧩 SQL Scripts – Data Warehouse Layers

This folder contains all SQL scripts used to build and manage the **Data Warehouse** following the **Medallion Architecture (Bronze, Silver, Gold)** pattern.

Each subfolder represents a logical layer in the data pipeline and must be executed in sequence.

---

## 📁 Folder Structure

```text
scripts/
│
├── bronze/ # Raw data ingestion scripts
├── silver/ # Data cleaning & transformation scripts
├── gold/ # Analytics & reporting layer scripts
```
---

## 🥉 Bronze Layer (Raw Data)

**Purpose:**
- Ingest raw data from source systems (ERP & CRM)
- Preserve data in its original format
- No transformations applied

**Characteristics:**
- Direct CSV ingestion
- Minimal validation
- Source-aligned schemas

**Execution Order:** FIRST

⚠️ **Warning:**  
Do not apply transformations in this layer.  
Bronze is meant for traceability and auditing.

---

## 🥈 Silver Layer (Cleaned Data)

**Purpose:**
- Clean and standardize raw data
- Handle nulls, duplicates, and data type issues
- Prepare data for analytics

**Transformations Include:**
- Deduplication
- Data type casting
- Null handling
- Standardized naming

**Execution Order:** AFTER Bronze

⚠️ **Warning:**  
Silver scripts depend on Bronze tables.  
Ensure all Bronze scripts have executed successfully.

---

## 🥇 Gold Layer (Analytics)

**Purpose:**
- Create business-ready datasets
- Implement star schema (Fact & Dimension tables)
- Optimize for analytical queries

**Includes:**
- Fact tables
- Dimension tables
- Aggregated metrics

**Execution Order:** AFTER Silver

⚠️ **Warning:**  
Gold scripts rely on cleaned Silver data.  
Never run Gold scripts before Silver.

---

## 🚀 Execution Guidelines

1. Run all scripts in `bronze/`
2. Validate Bronze data
3. Run all scripts in `silver/`
4. Validate Silver transformations
5. Run all scripts in `gold/`

---

## 🛡️ Notes

- Each layer is implemented as a **separate MySQL database**
- MySQL treats databases as schemas
- This design aligns with Medallion Architecture best practices
