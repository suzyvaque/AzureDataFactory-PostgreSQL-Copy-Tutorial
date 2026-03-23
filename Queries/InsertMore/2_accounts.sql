WITH existing_customers AS (
    SELECT
        customer_id,
        ROW_NUMBER() OVER (ORDER BY customer_id) AS rn
    FROM demo.customers
),
params AS (
    SELECT
        COALESCE(MAX(account_id), 0) AS max_account_id,
        (SELECT COUNT(*) FROM existing_customers) AS customer_count
    FROM demo.accounts
)
INSERT INTO demo.accounts (
    account_id,
    customer_id,
    account_type,
    balance,
    currency_code,
    status
)
SELECT
    p.max_account_id + gs AS account_id,
    c.customer_id,
    CASE WHEN (p.max_account_id + gs) % 2 = 0 THEN 'Checking' ELSE 'Savings' END,
    ROUND((random() * 10000000)::numeric, 2),
    'KRW',
    CASE WHEN (p.max_account_id + gs) % 20 = 0 THEN 'Dormant' ELSE 'Active' END
FROM params p
JOIN LATERAL generate_series(1, CASE WHEN p.customer_count > 0 THEN 40000 ELSE 0 END) gs ON TRUE
JOIN existing_customers c
    ON c.rn = (((p.max_account_id + gs - 1) % p.customer_count) + 1);
