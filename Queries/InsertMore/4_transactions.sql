WITH existing_accounts AS (
    SELECT
        account_id,
        ROW_NUMBER() OVER (ORDER BY account_id) AS rn
    FROM demo.accounts
),
params AS (
    SELECT
        COALESCE(MAX(transaction_id), 0) AS max_transaction_id,
        (SELECT COUNT(*) FROM existing_accounts) AS account_count,
        GREATEST(1000000 - COUNT(*), 0) AS rows_to_add
    FROM demo.transactions
)
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
    p.max_transaction_id + gs AS transaction_id,
    a.account_id,
    CASE WHEN random() > 0.5 THEN 'Debit' ELSE 'Credit' END,
    ROUND((random() * 200000)::numeric, 2),
    'Merchant_' || (((p.max_transaction_id + gs - 1) % 200) + 1),
    CURRENT_TIMESTAMP - (random() * interval '30 days'),
    CURRENT_TIMESTAMP - (random() * interval '1 day')
FROM params p
JOIN LATERAL generate_series(1, CASE WHEN p.account_count > 0 THEN p.rows_to_add ELSE 0 END) gs ON TRUE
JOIN existing_accounts a
    ON a.rn = (((p.max_transaction_id + gs - 1) % p.account_count) + 1);
