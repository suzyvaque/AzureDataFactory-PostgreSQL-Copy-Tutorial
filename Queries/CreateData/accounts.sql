INSERT INTO demo.accounts (
    account_id,
    customer_id,
    account_type,
    balance,
    currency_code,
    status
)
SELECT
    gs,
    ((gs - 1) % 50000) + 1,
    CASE WHEN gs % 2 = 0 THEN 'Checking' ELSE 'Savings' END,
    ROUND((random() * 10000000)::numeric, 2),
    'KRW',
    CASE WHEN gs % 20 = 0 THEN 'Dormant' ELSE 'Active' END
FROM generate_series(1, 100000) gs;