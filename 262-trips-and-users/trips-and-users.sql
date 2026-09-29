WITH cte AS (
    SELECT t.*
    FROM Trips t
    JOIN Users u1
        ON t.client_id = u1.users_id
    JOIN Users u2
        ON t.driver_id = u2.users_id
    WHERE u1.banned = 'No'
      AND u2.banned = 'No'
      AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
)

SELECT
    request_at AS Day,
    ROUND(
        SUM(
            CASE
                WHEN status IN (
                    'cancelled_by_client',
                    'cancelled_by_driver'
                )
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS `Cancellation Rate`
FROM cte
GROUP BY request_at;