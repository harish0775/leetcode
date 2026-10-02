# Write your MySQL query statement below

-- select * from Numbers n1
-- left join Numbers n2
-- on n1.num = n2.num;
WITH RECURSIVE cte AS (
    SELECT
    1 as sr,
    num,
    frequency,
    1 AS n
    from Numbers 
    UNION ALL
    SELECT
    sr+1,
    num,
    frequency,
    n + 1
    FROM cte
    WHERE sr < frequency
),
sequence_row as (
    SELECT
    num,
    sr,
    ROW_NUMBER() OVER (
        ORDER BY num, sr
    ) AS overall_sequence
FROM cte
ORDER BY num, sr
),
almostfinal AS (
    SELECT
        FLOOR((COUNT(*) OVER () + 1) / 2) AS r,
        FLOOR((COUNT(*) OVER () + 2) / 2) AS r2,
        num,
        sr,
        overall_sequence
    FROM sequence_row
),
nexfinal as (
select
num
from almostfinal  where overall_sequence >= r AND overall_sequence <= r2
)

select AVG(num) AS median from nexfinal;


