WITH numbered AS (
    SELECT
    user_id,
    action_date,
    MIN(action) AS action,
      ROW_NUMBER() OVER (
            PARTITION BY user_id, action
            ORDER BY action_date
        ) AS rn
    FROM activity
    GROUP BY user_id, action_date
    HAVING COUNT(*) = 1
),
grouped AS (
    SELECT *,
        DATE_SUB(action_date, INTERVAL rn DAY) AS group_key
    FROM numbered
),
streaks AS (
    SELECT
        user_id,
        action,
        COUNT(*) AS streak_length,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date
    FROM grouped
    GROUP BY user_id, action, group_key
    HAVING COUNT(*) >= 5
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY streak_length DESC, start_date ASC, action ASC
        ) AS streak_rank
    FROM streaks
)
SELECT
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM ranked
WHERE streak_rank = 1
ORDER BY streak_length DESC, user_id ASC;