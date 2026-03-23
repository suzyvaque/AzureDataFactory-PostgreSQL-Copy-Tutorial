# 1. Create Data

## 1️⃣ Connect to server in Powershell

Run on VM Powershell:

```powershell
psql -U postgres -h localhost -p 5432
```

<br>

### Set password

**If password is required but you did not yet set it up:**

Go to `C:\Program Files\PostgreSQL\16\data` and open `pg_hba.conf`.

Update IPv4 `127.0.0.1/32`, IPv6 `::1/128` local connections from `scram-sha-256` to `trust`.

<br>


Then run on VM Powershell:

```powershell
Restart-Service *postgres*
psql -U postgres -h localhost -p 5432

# Now we can connect to server without password
ALTER USER postgres WITH PASSWORD '{your new password}';
```

<br>

Update `pg_hba.conf`'s `trust` back to `scram-sha-256`.

Then run on VM Powershell:

```powershell
Restart-Service *postgres*
psql -U postgres -h localhost -p 5432

# Now we can connect with new password
```

<br>

## 2️⃣ Connect to server in pgAdmin

Open installed **pgAdmin**.

Connect to server by choosing `Existing Server` and typing in the password we just set above.

* User `postgres` is default admin user
* Connect with admin password- admin's password is identical to server password

<br>

## 3️⃣ Set up database

In pgAdmin's query tool, create new user with your user name:

```SQL
CREATE ROLE suzyvaque WITH
LOGIN
PASSWORD '{password}';
```

Then create a new database:

```SQL
CREATE DATABASE pg_adf_connect_db
OWNER suzyvaque;
```

<br>

## 4️⃣ Create schema

Click default workspace, choose this new database, right click and select Query Tool.

Run DDL in Query Tool:

```SQL
CREATE SCHEMA demo AUTHORIZATION suzyvaque;
```

<br>

## 5️⃣ Create tables

We will create these tables:

* customers (~50K rows)
* accounts (~100K rows)
* transactions (~300K rows) ← main fact table
* cards (~100K rows)
* branches (~100 rows)

<br>

Run SQL queries in Query Tool:

1. [DDL.sql](./PostgreSQL/Queries/DDL.sql)
2. [customers.sql](./PostgreSQL/Queries/customers.sql)
3. [accounts.sql](./PostgreSQL/Queries/accounts.sql)
4. [transactions.sql](./PostgreSQL/Queries/transactions.sql)
5. [cards.sql](./PostgreSQL/Queries/cards.sql)
6. [branches.sql](./PostgreSQL/Queries/branches.sql)

<br>

## 6️⃣ Inspect data

### Check number of rows created

```SQL
SELECT 'customers' AS table_name, COUNT(*) FROM demo.customers
    UNION ALL
    SELECT 'accounts', COUNT(*) FROM demo.accounts
    UNION ALL
    SELECT 'transactions', COUNT(*) FROM demo.transactions
    UNION ALL
    SELECT 'cards', COUNT(*) FROM demo.cards
    UNION ALL
    SELECT 'branches', COUNT(*) FROM demo.branches;
```

Expected:

* customers → 50000
* accounts → 100000
* transactions → 300000
* cards → 100000
* branches → 100

<br>

### Inspect data in tables

```SQL
SELECT
    c.full_name,
    a.account_id,
    a.account_type,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.merchant_name,
    t.transaction_ts
FROM demo.customers c
JOIN demo.accounts a
    ON c.customer_id = a.customer_id
JOIN demo.transactions t
    ON a.account_id = t.account_id
ORDER BY t.transaction_ts DESC
LIMIT 20;
```
