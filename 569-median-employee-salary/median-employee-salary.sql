# Write your MySQL query statement below

with cte as 
(
select 
id,
company,
salary, 
row_number() over(partition by company order by salary asc) as rnk,
count(id) over(partition by company) as n
from Employee
)
select 
id,
company,
salary
 from cte  where rnk between n/2 AND n/2+1;