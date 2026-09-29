# Write your MySQL query statement below
with cte as (
select
id,
departmentId,
name,
Salary,
DENSE_RANK() OVER(
    PARTITION BY departmentId
     ORDER BY salary DESC
     ) as rnk
from Employee
)

select 
d.name as Department, 
c.name as Employee,
c.Salary as Salary
 from cte c
left join Department d
on c.departmentId = d.id
where c.rnk <4
ORDER BY Salary DESC 


