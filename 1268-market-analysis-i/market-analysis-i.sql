# Write your MySQL query statement below

with cte as (select
buyer_id,
count(buyer_id) as orders_in_2019
from Orders WHERE YEAR(order_date) = 2019
group by buyer_id)

select 
u.user_id as buyer_id,
u.join_date as join_date,
IFNULL(c.orders_in_2019,0) as orders_in_2019
from Users u
left join cte c 
on u.user_id = c.buyer_id;