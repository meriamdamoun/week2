select distinct * from items order by price asc

select distinct * from items where price >= 80 order by price desc

select customer_id, first_name from customers
order by first_name asc
limit 3

select last_name from customers order by last_name desc 