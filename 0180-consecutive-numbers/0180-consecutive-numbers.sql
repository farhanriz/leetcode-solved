-- Write your PostgreSQL query statement below
with a as (
    select  *,
            lead(num,1) over (order by id) as lead_1,
            lead(num,2) over (order by id) as lead_2
    from Logs)
select distinct num as "ConsecutiveNums"
from a
where num=lead_1 and lead_1=lead_2