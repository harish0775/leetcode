# Write your MySQL query statement below

-- with cte as 
-- (
-- select 
-- id,
-- company,
-- salary, 
-- row_number() over(partition by company order by salary asc) as rnk,
-- count(id) over(partition by company) as n
-- from Employee
-- )
-- select 
-- id,
-- company,
-- salary
--  from cte  where rnk between n/2 AND n/2+1;

with T as (
select *, 
row_number() over(partition by company order by salary, id)r,
count(*) over(partition by company) / 2 as r1,
count(*) over(partition by company) /2 + 1 as r2 from Employee)

select id, company, salary from T where r between r1 and r2























