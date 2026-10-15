# Write your MySQL query statement below

with filter_user_id as (
    select
 user_id
 from course_completions
 group by user_id
 HAVING count(user_id)>=5 and AVG(course_rating) >=4
),
filter_course_completions as (
select 
u.user_id as user_id,
u.course_id as course_id,
u.course_name as course_name,
u.completion_date as completion_date,
u.course_rating  as course_rating
from course_completions u
left join  filter_user_id f
on u.user_id = f.user_id
where f.user_id IS NOT NULL
),almost as (
    select
course_name as first_course,
  LEAD(course_name) OVER (
            PARTITION BY user_id
            ORDER BY completion_date, course_id
        ) AS second_course
from filter_course_completions
GROUP BY user_id, course_name
)

select 
first_course,
second_course,
count(*) as transition_count
from almost 
WHERE  second_course IS NOT NULL
group by first_course,second_course
order by transition_count desc,first_course ASC,second_course ASC