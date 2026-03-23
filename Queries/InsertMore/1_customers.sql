INSERT INTO demo.customers (
    customer_id,
    full_name,
    email,
    phone,
    city
)
SELECT
    p.max_customer_id + gs AS customer_id,
    'Customer_' || (p.max_customer_id + gs),
    'user' || (p.max_customer_id + gs) || '@example.com',
    '010-' || LPAD((((p.max_customer_id + gs) % 10000)::text), 4, '0') || '-' || LPAD(((((p.max_customer_id + gs) * 7) % 10000)::text), 4, '0'),
    CASE
        WHEN (p.max_customer_id + gs) % 5 = 0 THEN 'Seoul'
        WHEN (p.max_customer_id + gs) % 5 = 1 THEN 'Busan'
        WHEN (p.max_customer_id + gs) % 5 = 2 THEN 'Incheon'
        WHEN (p.max_customer_id + gs) % 5 = 3 THEN 'Daegu'
        ELSE 'Daejeon'
    END
FROM (
    SELECT
        COALESCE(MAX(customer_id), 0) AS max_customer_id,
        GREATEST(100000 - COUNT(*), 0) AS rows_to_add
    FROM demo.customers
) p
CROSS JOIN LATERAL generate_series(1, p.rows_to_add) gs;
