-- Write your PostgreSQL query statement below
with first as (
    select 
        player_id, 
        min(event_date) min_date
        --row_number over(partition by player_id order by event_date asc) as row_num,
    from Activity
    group by 1
    ),
second as (
        select 
        player_id, 
        event_date,
        row_number() over(partition by player_id order by event_date asc) as row_num
    from Activity
    order by player_id, event_date
),
final as (
    select f.player_id as player_id,
    case when s.event_date - f.min_date = 1 then 1
    else 0 end as fractions, 
    row_num
from first f
left join (select * from second where row_num = 2) as s 
on f.player_id = s.player_id
)
select round(((sum(fractions))::float/(count(distinct player_id))::float)::numeric,2) fraction
from final