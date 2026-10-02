WITH RECURSIVE   
ct1 AS (    
    SELECT   
        id,   
        month AS seq,   
        salary   
    FROM Employee
),   

numbers AS (    
    SELECT    
        id,    
        MIN(seq) AS seq,    
        MAX(seq) AS max_seq
    FROM ct1    
    GROUP BY id
    
    UNION ALL    
    
    SELECT    
        id,    
        seq + 1,    
        max_seq
    FROM numbers    
    WHERE seq < max_seq    
),   

records AS (   
    SELECT    
        n.id,    
        n.seq,
        CASE   
            WHEN t.seq IS NULL THEN 0   
            ELSE 1    
        END AS is_worked,   
        IFNULL(t.salary, 0) AS salary   
    FROM numbers n    
    LEFT JOIN ct1 t   
        ON n.id = t.id   
       AND n.seq = t.seq    
),

record2 AS (
    SELECT
        id,
        seq,
        salary,
        is_worked,
        SUM(salary) OVER (
            PARTITION BY id
            ORDER BY seq
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS cumulative_salary
    FROM records
),

record3 AS (
    SELECT
        *,
        MAX(
            CASE 
                WHEN is_worked = 1 THEN seq 
            END
        ) OVER (
            PARTITION BY id
        ) AS latest_month
    FROM record2
)

SELECT
    id,
    seq AS month,
    cumulative_salary AS Salary
FROM record3
WHERE is_worked = 1
  AND seq <> latest_month
ORDER BY id ASC, month DESC;