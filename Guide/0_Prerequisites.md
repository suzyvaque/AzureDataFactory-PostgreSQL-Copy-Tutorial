# Prerequisites

## Azure Virtual Machine

Windows OS (Required for SHIR installation)

Connect with Bastion (Run on local Powershell)

```powershell
az login
az network bastion rdp --name "{vm-bastion-name}" --resource-group "{vm-resource-group-name}" --target-resource-id "{vm-resource-id}"
```

* Provide **Azure credentials** for az login
* Provide **VM credentials** for Bastion connection to VM
* If Bastion connection fails before providing credentials, check if **Azure VM is running**

<br>

## PostgreSQL 16 Server

Run on VM Powershell

```powershell
winget search postgresql
winget install --id PostgreSQL.PostgreSQL.16 -e
Get-Service *postgres*
psql --version

# If not recognized
$env:Path += ";C:\Program Files\PostgreSQL\16\bin"
```

<br>

## pgAdmin

Run on VM Powershell

```powershell
winget search pgadmin
winget install --id PostgreSQL.pgAdmin -e
```

<br>

## Azure Data Factory Resource

## Azure Storage Account Resource

* ADLS Gen2
