# ⚽ Football Ticket Booking System - Database Project

## 📌 Project Overview
This project is a relational database design and SQL implementation for a Football Ticket Booking System.  
It simulates real-world ticket booking operations including users, football matches, and booking transactions.

The system is built to demonstrate:
- ERD (Entity Relationship Design)
- Primary & Foreign Key relationships
- SQL queries with joins, filtering, aggregation, and subqueries
- Data integrity using constraints

---

## 🧱 Database Structure

The system contains **3 main tables**:

### 👤 Users Table
Stores information about system users (fans and ticket managers).

**Fields:**
- user_id (Primary Key)
- full_name
- email (Unique)
- role (Football Fan / Ticket Manager)
- phone_number

---

### ⚽ Matches Table
Stores football match details and ticket pricing.

**Fields:**
- match_id (Primary Key)
- fixture (Team vs Team)
- tournament_category
- base_ticket_price
- match_status (Available, Sold Out, etc.)

---

### 🎟️ Bookings Table
Stores ticket booking transactions linking users and matches.

**Fields:**
- booking_id (Primary Key)
- user_id (Foreign Key → Users)
- match_id (Foreign Key → Matches)
- seat_number
- payment_status (Confirmed, Pending, etc.)
- total_cost

---

## 🔗 Database Relationships

- One User → Many Bookings
- One Match → Many Bookings
- Bookings acts as a bridge between Users and Matches

---

## 🧠 Concepts Used

- SQL DDL (CREATE, DROP, ALTER)
- Primary Key & Foreign Key Constraints
- JOIN operations (INNER JOIN, LEFT JOIN)
- Subqueries
- Aggregate functions (COUNT, AVG, SUM)
- Filtering (WHERE, LIKE, ILIKE)
- NULL handling (COALESCE)
- Sorting and pagination (ORDER BY, LIMIT, OFFSET)

---

## 📊 Sample Features Implemented

- Retrieve available matches by tournament
- Search users using pattern matching
- Handle missing payment data safely
- Combine user and match data using joins
- Calculate averages and filter results
- Find top expensive matches using sorting

---

## 📂 Project Files

- schema.sql → Table creation queries
- seed.sql → Insert sample data
- queries.sql → All SQL practice queries
- README.md → Project documentation

---

## 🚀 How to Run

1. Create database in PostgreSQL
2. Run `schema.sql` to create tables
3. Run `seed.sql` to insert data
4. Run `queries.sql` to test queries

---

## 👨‍💻 Author

Football Ticket Booking System - Database Assignment  
Developed for academic submission and SQL practice.

---

## 📌 Note

This project is designed strictly according to assignment requirements including ERD design, relational integrity, and SQL query implementation.

