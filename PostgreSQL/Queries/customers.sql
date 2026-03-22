INSERT INTO demo.customers (
    customer_id,
    full_name,
    email,
    phone,
    city
)
SELECT
    gs,
    'Customer_' || gs,
    'user' || gs || '@example.com',
    '010-' || LPAD(((gs % 10000)::text), 4, '0') || '-' || LPAD((((gs * 7) % 10000)::text), 4, '0'),
    CASE
        WHEN gs % 5 = 0 THEN 'Seoul'
        WHEN gs % 5 = 1 THEN 'Busan'
        WHEN gs % 5 = 2 THEN 'Incheon'
        WHEN gs % 5 = 3 THEN 'Daegu'
        ELSE 'Daejeon'
    END
FROM generate_series(1, 50000) gs;