# Write your MySQL query statement below

with cte as (
    select 
p.product_id as product_id,
ROUND(SUM(u.units * p.price)/SUM(units),2) as average_price
from Prices p
left join UnitsSold u
on p.product_id = u.product_id
where u.purchase_date BETWEEN p.start_date  and p.end_date
group by p.product_id
),
unit as (select * from Prices group by product_id) 

select
u.product_id as product_id,
IFNULL(c.average_price,0) as average_price 
from unit u
 left join cte c
 on u.product_id = c.product_id;
