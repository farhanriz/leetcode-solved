-- Write your PostgreSQL query statement below
select p.product_name, year, price from Product p
inner join Sales s on s.product_id = p.product_id