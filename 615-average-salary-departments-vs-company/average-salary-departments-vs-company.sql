with cte as (
    select 
s.id as id,
e.employee_id as employee_id,
e.department_id as department_id,
DATE_FORMAT(s.pay_date, '%Y-%m') as pay_date,
s.amount as amount
from Salary s
left join Employee e
on s.employee_id = e.employee_id
),
department_avg AS (
select 
employee_id,
department_id,
pay_date,
AVG(amount) as d_avg 
from cte
group by department_id,pay_date
),
company_avg as (
select 
employee_id,
department_id,
pay_date,
AVG(amount)  as c_avg
from cte
group by pay_date
)

select 
d.pay_date as pay_month, 
d.department_id as department_id,
CASE 
   WHEN c.c_avg < d.d_avg THEN 'higher'
   WHEN c.c_avg = d.d_avg THEN 'same'
   WHEN c.c_avg > d.d_avg THEN 'lower' 
   END as comparison
from department_avg d
left join company_avg c
on d.pay_date = c.pay_date
group by d.employee_id,d.pay_date

