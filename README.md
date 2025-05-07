# 🎓 Oracle SQL Lab Work – Docker + SQL Scripts

This repository contains SQL lab assignments and a pre-configured Docker setup for running Oracle XE (Express Edition) locally.

## 📦 Contents

- `docker-compose.yml` — Docker setup for Oracle XE
- `sql/` — Folder containing SQL scripts for:
  - Table creation with constraints
  - Data insertion
  - Complex SELECT queries (20+ advanced queries)
  - Additional schema operations

## 🐳 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/oracle-sql-lab.git
cd oracle-sql-lab
```

### 2. Start Oracle XE with Docker

```bash
docker-compose up -d
```

The database will be available at:
- Host: localhost
- Port: 1521
- Service Name: XEPDB1
- Username: nure_queue (or as defined in your script)
- Password: 1111

### 3. Connect to the Database

You can use tools like:
- SQL Developer
- DBeaver
- SQL*Plus (inside container or host machine)
