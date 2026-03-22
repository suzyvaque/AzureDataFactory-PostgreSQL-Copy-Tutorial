INSERT INTO demo.cards (
    card_id,
    account_id,
    card_type,
    card_number,
    card_status
)
SELECT
    gs,
    gs,
    CASE WHEN gs % 2 = 0 THEN 'Credit' ELSE 'Debit' END,
    '400000' || LPAD(gs::text, 10, '0'),
    CASE WHEN gs % 25 = 0 THEN 'Blocked' ELSE 'Active' END
FROM generate_series(1, 100000) gs;