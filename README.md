# Azure Data Factory Copy Tutorial

This tutorial walks through a full demo where PostgreSQL is hosted on an Azure VM and data is copied with Azure Data Factory (ADF).

## Tutorial Flow

1. Prerequisites and environment setup
2. PostgreSQL data generation on the VM
3. Connect ADF with Self-hosted Integration Runtime (SHIR)
4. Build copy pipeline and run initial load
5. Run incremental sync

## Step-by-Step Guides

- Step 0: [Prerequisites](./Guide/0_Prerequisites.md)
- Step 1: [Create Data in PostgreSQL](./Guide/1_CreateData.md)
- Step 2: [Connect with SHIR](./Guide/2_ConnectSHIR.md)
- Step 3: [Build Copy Data Pipeline with ADF](./Guide/3_LoadData.md)
- Step 4: [Incremental Sync with ADF](./Guide/4_SyncData.md)

## Notes

- `Prerequisites.md` covers setting up Azure resources and PostgreSQL server in VM.
