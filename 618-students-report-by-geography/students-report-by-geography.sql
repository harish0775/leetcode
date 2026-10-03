 with cte as (
 select
 name,
 continent,
 ROW_NUMBER() OVER (
    PARTITION BY continent
    ORDER BY name
    ) as rnk
    from Student 
 ), 
 cte2 as (
    SELECT
     MAX(CASE WHEN continent = 'America' THEN name END) AS America,
     MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
     MAX(CASE WHEN continent = 'Europe' THEN name END)  AS Europe
FROM cte
GROUP BY rnk
 )
 select 
 *
 from cte2;

