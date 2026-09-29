with cte as (
select * from Customer 
group by customer_id,product_key
)
select 
c.customer_id as customer_id
from Product p
left join cte c
on p.product_key = c.product_key
group by c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(product_key) FROM Product)
