WITH existing_accounts AS (
    SELECT
        account_id,
        ROW_NUMBER() OVER (ORDER BY account_id) AS rn
    FROM demo.accounts
),
params AS (
    SELECT
        COALESCE(MAX(card_id), 0) AS max_card_id,
        (SELECT COUNT(*) FROM existing_accounts) AS account_count
    FROM demo.cards
)
INSERT INTO demo.cards (
    card_id,
    account_id,
    card_type,
    card_number,
    card_status
)
SELECT
    p.max_card_id + gs AS card_id,
    a.account_id,
    CASE WHEN (p.max_card_id + gs) % 2 = 0 THEN 'Credit' ELSE 'Debit' END,
    '455555' || LPAD((p.max_card_id + gs)::text, 10, '0'),
    CASE WHEN (p.max_card_id + gs) % 25 = 0 THEN 'Blocked' ELSE 'Active' END
FROM params p
JOIN LATERAL generate_series(1, CASE WHEN p.account_count > 0 THEN 40000 ELSE 0 END) gs ON TRUE
JOIN existing_accounts a
    ON a.rn = (((p.max_card_id + gs - 1) % p.account_count) + 1);
