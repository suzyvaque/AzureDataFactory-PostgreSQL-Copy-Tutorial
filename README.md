# Demo for ADF

## 0️⃣ Prerequisites

### Azure Virtual Machine

Windows OS (Required for SHIR installation)

Connect with Bastion (Run on local Powershell)

```powershell
az login
az network bastion rdp --name "{vm-bastion-name}" --resource-group "{vm-resource-group-name}" --target-resource-id "{vm-resource-id}"
```

* Provide **Azure credentials** for az login
* Provide **VM credentials** for Bastion connection to VM
* If Bastion connection fails before providing credentials, check if **Azure VM is running**

### PostgreSQL 16 Server

Run on VM Powershell

```powershell
winget search postgresql
winget install --id PostgreSQL.PostgreSQL.16 -e
Get-Service *postgres*
psql --version

# If not recognized
$env:Path += ";C:\Program Files\PostgreSQL\16\bin"
```

Try connecting to PostgreSQL Server

```powershell
psql -U postgres -h localhost -p 5432
```

* If password is required but you did not yet set it up, go to `C:\Program Files\PostgreSQL\16\data` and open `pg_hba.conf`
* Update IPv4 `127.0.0.1/32`, IPv6 `::1/128` local connections from `scram-sha-256` to `trust`

```powershell
Restart-Service *postgres*
psql -U postgres -h localhost -p 5432

# Now we can connect to server without password
ALTER USER postgres WITH PASSWORD '{your new password}';
```

* Update `pg_hba.conf`'s `trust` back to `scram-sha-256`

```powershell
Restart-Service *postgres*
psql -U postgres -h localhost -p 5432

# Now we can connect with new password
```

### PGAdmin

Run on VM Powershell

```powershell
winget search pgadmin
winget install --id PostgreSQL.pgAdmin -e
```

Connect to server by choosing `Existing Server` and typing in the password we just set above.

* User `postgres` is default admin user
* Connect with admin password- admin's password is identical to server password

### Azure Data Factory Resource

### Azure Storage Account Resource

* ADLS Gen2

## 1️⃣ Create Data

* customers (~50K rows)
* accounts (~100K rows)
* transactions (~300K rows) ← main fact table
* cards (~100K rows)
* branches (~100 rows)

## 2️⃣ Install SHIR

## 3️⃣ Connect ADF

## 4️⃣ Copy Data

## 5️⃣ Sync Data
