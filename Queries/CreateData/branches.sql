INSERT INTO demo.branches (
    branch_id,
    branch_name,
    city
)
SELECT
    gs,
    'Branch_' || gs,
    CASE
        WHEN gs % 5 = 0 THEN 'Seoul'
        WHEN gs % 5 = 1 THEN 'Busan'
        WHEN gs % 5 = 2 THEN 'Incheon'
        WHEN gs % 5 = 3 THEN 'Daegu'
        ELSE 'Daejeon'
    END
FROM generate_series(1, 100) gs;