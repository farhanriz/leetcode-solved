# Write your MySQL query statement below
with a as(
    select name,salary, departmentId,
    DENSE_RANK() OVER (partition by departmentId order by salary desc) as rnk
    from Employee
    )
select d.name Department, a.name Employee, salary Salary from a
left join Department d on d.id = a.departmentId
where rnk <= 3