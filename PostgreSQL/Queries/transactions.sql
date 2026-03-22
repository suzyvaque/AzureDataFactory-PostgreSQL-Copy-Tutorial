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
    CASE WHEN random() > 0.5 THEN 'Debit' ELSE 'Credit' END,
    ROUND((random() * 200000)::numeric, 2),
    'Merchant_' || ((gs - 1) % 200 + 1),
    CURRENT_TIMESTAMP - (random() * interval '30 days'),
    CURRENT_TIMESTAMP - (random() * interval '1 day')
FROM generate_series(1, 300000) gs;