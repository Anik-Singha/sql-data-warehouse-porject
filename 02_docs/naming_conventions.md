# 🏷️ Naming Conventions

This document describes the basic naming rules used in this data warehouse.
The goal is to keep names **consistent, readable, and easy to understand**.

---

## 🔹 General Rules

- Use `snake_case` (lowercase + underscores)
- Use English names only
- Avoid SQL reserved keywords
- Keep names clear and meaningful

---

## 🗂️ Table Naming

### 🥉 Bronze Layer
Raw data from source systems.
All names starts with the source system names (eg., crm, erp) and 
the tables must match their original names.

**Pattern**

**Example**
- `crm_customer_info`

---

### 🥈 Silver Layer
Cleaned and standardized data.
Table names stay the same as Bronze.

**Pattern**

**Example**
- `crm_customer_info`

---

### 🥇 Gold Layer
Business-ready tables for analytics.

**Pattern**

**Examples**
- `dim_customers`
- `fact_sales`

**Common Categories**
- `dim_` → Dimension tables  
- `fact_` → Fact tables  
- `report_` → Reporting tables  

---

## 🧱 Column Naming

### 🔑 Surrogate Keys
Used in dimension tables.

**Pattern**

**Example**
- `customer_key`

---

### ⚙️ Technical Columns
System-generated metadata.

**Pattern**

**Example**
- `dwh_load_date`

---

## 🔄 Stored Procedures

Used to load data into layers.

**Pattern**

**Examples**
- `load_bronze`
- `load_silver`
- `load_gold`
