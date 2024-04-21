# Write your MySQL query statement below
with a as (
select departmentId, max(salary) max_salary
    from Employee
group by 1
)
SELECT d.name Department, e.name Employee, salary Salary 
    from Employee e
left join a on a.departmentId = e.departmentId
left join Department d on a.departmentId = d.id and e.salary = max_salary
where d.name is not null
