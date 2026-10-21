# Write your MySQL query statement below

select user_id ,CONCAT(UPPER(SUBSTRING(name FROM 1 FOR 1)), LOWER(SUBSTRING(name FROM 2))) AS name  from Users order by user_id ASC;