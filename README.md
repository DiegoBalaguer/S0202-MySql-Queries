# S2.02 - MySQL Queries Practice

---

# 🎯 Objectives

- Learn to query a SQL database effectively
- Practice writing various types of SQL queries
- Understand database relationships and joins
- Master aggregation and filtering techniques

---

## 🔹 Store Database Exercises

### 📌 Database Schema
We have two tables:
- `producto` (codigo, nombre, precio, codigo_fabricante)
- `fabricante` (codigo, nombre)

The `codigo_fabricante` field in `producto` relates to `codigo` in `fabricante`.

---

### 📘 Basic Queries (01-15)
01. List all product names
02. List product names and prices
03. List all columns from producto
04. List names with prices in EUR and USD
05. Same as #4 with column aliases
06. List names (uppercase) and prices
07. List names (lowercase) and prices
08. List manufacturer names with first 2 chars in uppercase
09. List names and rounded prices
10. List names and prices truncated to integers
11. List manufacturer codes that have products
12. List unique manufacturer codes with products
13. List manufacturer names (A-Z)
14. List manufacturer names (Z-A)
15. List products sorted by name (A-Z) then price (high-low)

---

### 📘 Intermediate Queries (16-32)
16. First 5 manufacturers
17. 2 rows starting from 4th row
18. Cheapest product (using ORDER BY/LIMIT)
19. Most expensive product (using ORDER BY/LIMIT)
20. Products from manufacturer #2
21. Products with manufacturer names
22. Products sorted by manufacturer name
23. Full product-manufacturer details
24. Cheapest product with manufacturer
25. Most expensive product with manufacturer
26. All Lenovo products
27. Crucial products > €200
28. Products from Asus, HP, Seagate (without IN)
29. Products from Asus, HP, Seagate (with IN)
30. Products from manufacturers ending with 'e'
31. Products from manufacturers containing 'w'
32. Products ≥ €180 sorted by price (high-low) then name (A-Z)

---

### 📘 Advanced Queries (33-41)
33. Manufacturers with products
34. All manufacturers with their products (including empty)
35. Manufacturers without products
36. Lenovo products (without INNER JOIN)
37. Products priced like Lenovo's most expensive
38. Lenovo's most expensive product name
39. HP's cheapest product name
40. Products ≥ Lenovo's most expensive
41. Asus products above average price

---

## 🔹 University Database Exercises

### 📌 Database Schema
Download `schema_universidad.sql` and view the ER diagram.

---

### 📘 Basic Queries (01-09)
01. Students sorted by last names and name
02. Students without phone numbers
03. Students born in 1999
04. Professors without phone and NIF ending with 'K'
05. 3rd year, 1st semester courses for degree #7
06. Professors with department names
07. Courses taken by student NIF 26902806M
08. Departments with Computer Engineering professors
09. Students enrolled in 2018/2019

---

### 📘 JOIN Queries (01-06)
01. All professors with departments (including unassigned)
02. Professors without departments
03. Departments without professors
04. Professors not teaching any courses
05. Courses without assigned professors
06. Departments that never taught any courses

---

### 📘 Summary Queries (01-11)
01. Total students
02. Students born in 1999
03. Professors per department (assigned only)
04. All departments with professor counts
05. All degrees with course counts
06. Degrees with >40 courses
07. Degrees with credit sums by course type
08. Enrollment counts by school year
09. Courses taught per professor
10. Youngest student data
11. Department professors not teaching

---

# 🛠️ Technologies Used

- MySQL (MariaDB)
- SQL Query Language
- Database Joins and Relationships
- Aggregation Functions

---

## ⚙️ Installation & Execution

### 📋 Requirements
- MySQL Server (MariaDB)
- MySQL Workbench, DBeaver, HeidiSQL or similar client
- schema_tienda_structure-datatest.sql file
- schema_universidad_structure-datatest.sql file

---

### 🛠️ Setup

2. Import the tienda database:
```sh
mysql -u username -p < schema_tienda_structure-datatest.sql

````

2. Import the universidad database:
```sh
mysql -u username -p < schema_universidad_structure-datatest.sql

````
### ▶️ Execution

Run the queries directly in your MySQL client:
```sql
-- For the Store database:
USE tienda;
SELECT * FROM producto;

-- For the University database: 
USE universidad;
SELECT * FROM alumno;
````

## 🏆 Achievement Levels

### 🥉 Level 1 (Basic)
- ✅ 37+ queries completed
- ✅ 20+ from University database
- 📌 Basic SELECT, WHERE, single-table queries

### 🥈 Level 2 (Intermediate)  
- ✅ 37-56 queries completed
- ✅ 20+ from University database  
- 📌 JOINs, multi-table ops, aggregations

### 🥇 Level 3 (Advanced)
- ✅ 56+ queries completed
- ✅ 20+ from University database
- 📌 Subqueries, complex aggregations, optimization

📝 *All levels require proper query syntax and accurate results*


# 🛠️ Technologies Used

- MySQL (MariaDb)
- Database Design Principles
- Entity-Relationship Modeling
- Normalization Techniques

---

# 🌐 Deployment

These database models are designed for educational purposes and can be implemented in any SQL environment.

---

## 📦 Repository

You can store your SQL implementation in any version control system like Git.

---

## ✅ Author Notes

These exercises are designed to give you practical experience with database modeling, relationships, and real-world scenario implementation.

After creating the databases, populate the tables with test data to verify that the relationships work correctly.

Happy modeling! 🚀