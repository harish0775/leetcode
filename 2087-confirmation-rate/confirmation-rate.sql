WITH record AS (
    SELECT *
    FROM Confirmations
    GROUP BY user_id, time_stamp, action
),
cte AS (
    SELECT
        u.user_id,
        CASE
            WHEN c.action = 'confirmed' THEN 1
            ELSE 0
        END AS action
    FROM Signups u
    LEFT JOIN record c
        ON u.user_id = c.user_id
)

SELECT
    user_id,
    ROUND(SUM(action) / COUNT(action), 2) AS confirmation_rate
FROM cte
GROUP BY user_id;