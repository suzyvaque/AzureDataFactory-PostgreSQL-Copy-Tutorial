INSERT INTO demo.transactions (
    transaction_id,
    account_id,
    transaction_type,
    amount,
    merchant_name,
    transaction_ts,
    updated_at
)
SELECT
    gs,
    ((gs - 1) % 100000) + 1,
    'Debit',
    ROUND((random() * 50000)::numeric, 2),
    'New_Merchant',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM generate_series(300001, 301000) gs;