# Write your MySQL query statement below
select 
DISTINCT(user_id) as user_id ,
count(DISTINCT follower_id) as followers_count
from Followers
group by user_id;