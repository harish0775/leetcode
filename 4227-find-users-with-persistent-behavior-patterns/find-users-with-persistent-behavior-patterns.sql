with numbered as (
    select 
user_id,
action_date,
action,
ROW_NUMBER() OVER(PARTITION BY user_id,action ORDER BY action_date) as rn
from activity
group by user_id,action_date
HAVING Count(*)=1
),grouped AS (
 SELECT 
 *,
 DATE_SUB(action_date, INTERVAL rn DAY) AS group_key
 from numbered
),
streaks AS (
    SELECT
        user_id,
        action,
        COUNT(*) AS streak_length,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date
    FROM grouped
    GROUP BY user_id, action
    HAVING COUNT(*) >= 5
)

select * from streaks ORDER BY streak_length desc,user_id asc;

