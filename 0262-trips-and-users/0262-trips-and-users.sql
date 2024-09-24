-- Write your PostgreSQL query statement below
select 
    request_at "Day", 
    ROUND(
        COUNT(1) FILTER (WHERE status in ('cancelled_by_driver','cancelled_by_client'))::decimal /
    Count(*),2) "Cancellation Rate"
from Trips t
inner join Users u on u.users_id = t.client_id and u.banned = 'No'
inner join Users u2 on u2.users_id = t.driver_id and u2.banned = 'No'
where request_at between '2013-10-01' and '2013-10-03'
group by 1