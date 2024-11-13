-- Write your PostgreSQL query statement below
with a as (select *,
lead(id,1) over (order by id) as lead_1,
lead(id,2) over (order by id) as lead_2
     from Stadium
where 
people >= 100
order by visit_date),
b as (select id  from a
where lead_2 - id = 2 
and lead_1 - id = 1
union
select lead_1 as id  from a
where lead_2 - id = 2 
and lead_1 - id = 1
union
select lead_2 as id  from a
where lead_2 - id = 2 
and lead_1 - id = 1)
select * from Stadium 
where id in (select * from b)
and people>=100