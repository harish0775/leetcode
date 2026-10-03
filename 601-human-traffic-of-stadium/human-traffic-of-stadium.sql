WITH t AS (
    SELECT
        id,
        visit_date,
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),
grop AS (
    SELECT grp
    FROM t
    GROUP BY grp
    HAVING COUNT(*) >= 3
)
SELECT
    id,
    visit_date,
    people
FROM t
WHERE grp IN (SELECT grp FROM grop)
ORDER BY visit_date;
