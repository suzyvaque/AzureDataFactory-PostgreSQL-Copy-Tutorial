# 2. Connect SHIR

## 1️⃣ Check Privileges

Run on VM Powershell:

```Powershell
# Check database sanity
psql -U suzyvaque -h localhost -d pg_adf_connect_db -p 5432
SELECT COUNT(*) FROM demo.transactions;

# Check PostgreSQL is running
Get-Service *postgres*
```

If user does not have enough privileges, run below:

```Powershell
# Grant privileges as admin who created db
psql -U postgres -h localhost -d pg_adf_connect_db -p 5432

# Read-only access
GRANT USAGE ON SCHEMA demo TO suzyvaque;
GRANT SELECT ON ALL TABLES IN SCHEMA demo TO suzyvaque;
ALTER DEFAULT PRIVILEGES IN SCHEMA demo GRANT SELECT ON TABLES TO suzyvaque;
```

<br>

## 2️⃣ Install SHIR

1. Launch Azure Data Studio.
2. Create a new integration runtime by selecting Manage menu, then clicking **Connections > Integration Runtimes**.
3. Runtime type should be **Self Hosted**.
4. Download and install runtime from the **Manual Setup** option. IntegrationRuntime_5.62.9517.2.msi)
5. Copy **Key1** from Manual Setup option, paste it to the installer as Auth Key.
6. Runtime node is registered. SHIR will now be running.

<br>

## 3️⃣ Add Linked Services

1. Choose **Conenctions > Linked Services**.
    
    <br>

2. Select **PostgreSQL**, connect **SHIR** with details below.
    * Server name: localhost
    * Port: 5432
    * Database name: pg_adf_connect_db
    * User name: suzyvaque (Your DB user name, **Should have at least Read-Only access to DB**)
    * Password: (Your DB user password, **Should have at least Read-Only access to DB**)
3. Test connection, then create PostgreSQL linked service.

    <br>

4. Select **Azure Data Lake Storage Gen2**, connect **SHIR** with details below.
    * Authentication type: **Account key**
5. Test connection, then create Azure Data Lake Storage Gen2 linked service.
