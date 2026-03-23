# Execution Order

These scripts are used to increase row counts after running `CreateData` scripts.

<br>

## Run order

Use this order to avoid foreign-key issues:

1. `1_customers.sql`
2. `2_accounts.sql`
3. `3_cards.sql`
4. `4_transactions.sql`

<br>

## Dependency notes

- `accounts.customer_id` depends on `customers.customer_id`
- `cards.account_id` depends on `accounts.account_id`
- `transactions.account_id` depends on `accounts.account_id`

<br>

## Expected rows

Expected counts if your current state is the original `CreateData` baseline:

| table | before (CreateData) | inserted by InsertMore | expected after one run |
|---|---:|---:|---:|
| `demo.customers` | 50,000 | +50,000 (top-up to target) | 100,000 |
| `demo.accounts` | 100,000 | +40,000 | 140,000 |
| `demo.cards` | 100,000 | +40,000 | 140,000 |
| `demo.transactions` | 300,000 | +700,000 (top-up to target) | 1,000,000 |
| `demo.branches` | 100 | +0 | 100 |

How dynamic scripts behave:

- `1_customers.sql` inserts only enough rows to reach 100,000 customers.
- `4_transactions.sql` inserts only enough rows to reach 1,000,000 transactions.
- `2_accounts.sql` always inserts 40,000 rows per run.
- `3_cards.sql` always inserts 40,000 rows per run.

<br>

## Safety notes

- Run these scripts only after `CreateData` scripts.
- Scripts are append-only (`INSERT` only).
- Scripts do not update or delete existing rows.
- New primary keys are generated from current `MAX(id)`, so existing IDs are preserved.
- FK values are chosen from actual existing parent IDs, so inserts remain valid even if IDs have gaps.
- `demo.branches` is not changed.

<br>

## Optional row-count check

```sql
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM demo.customers
UNION ALL
SELECT 'accounts', COUNT(*) FROM demo.accounts
UNION ALL
SELECT 'cards', COUNT(*) FROM demo.cards
UNION ALL
SELECT 'transactions', COUNT(*) FROM demo.transactions
UNION ALL
SELECT 'branches', COUNT(*) FROM demo.branches
ORDER BY table_name;
```
