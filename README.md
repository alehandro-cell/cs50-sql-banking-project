# Banking Application Database 
### CS50 SQL Final Project

A comprehensive relational database for a modern banking application featuring multi-account management, ATM tracking, recurring direct debits, Bizum payments, and a centralized transaction ledger for complete financial traceability.

---

## 🚀 About the Project
This project was developed as the final project for **CS50 SQL**. The goal was to design and implement a robust database system capable of handling core banking operations efficiently, ensuring data integrity, and providing deep traceability for every financial movement.

---

## 🗄️ Database Schema & Entities
The database architecture consists of several interconnected relational tables:

- **`users`**: Stores client personal information and credentials.
- **`accounts`**: Manages individual bank accounts linked to users (supports multiple accounts per user).
- **`atms`**: Tracks physical ATM locations where cash withdrawal transactions take place.
- **`transactions`**: The central ledger recording all financial movements (deposits, withdrawals, transfers).
- **`direct_debits`**: Handles recurring payments and automated bills.
- **`bizums`**: Manages peer-to-peer (P2P) mobile instant payments.

---

## 📊 Entity-Relationship Diagram
Here is the visual representation of the database schema and its table relationships:

![Entity-Relationship Diagram](diagram.png)

*(For a deep technical breakdown of design choices, optimizations, and limitations, check out the [DESIGN.md](DESIGN.md) file).*

---

## 📂 Repository Structure
- `schema.sql`: Contains the DDL statements (tables, constraints, indexes, and views).
- `queries.sql`: Contains complex DML queries used for analytics, account management, and transaction tracking.
- `DESIGN.md`: Detailed documentation explaining the design process and database structure.
- `diagram.png`: The visual ER diagram.

---

## ⚙️ How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/alehandro_cell/cs50-sql-banking-project.git
   ```
   ```bash
   sqlite3 bank.db
   ```
   ```bash
   .read schema.sql
   ```
   ```bash
   .read queries.sql
   ```

## 🛠️ Built With
- **[SQLite](https://www.sqlite.org/)** - Relational database engine used to implement the schema and handle data storage.
- **[SQL](https://en.wikipedia.org/wiki/SQL)** - Language used for DDL (schema creation) and DML (queries, updates, transactions).
- **[Markdown](https://daringfireball.net/projects/markdown/)** - Technical documentation (`DESIGN.md` and `README.md`).
- **[Mermaid](https://mermaid.js.org/)** - Entity-Relationship diagram generation.
   
