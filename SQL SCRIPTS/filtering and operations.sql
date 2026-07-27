--section C(FILTERING and OPERATIONS)

select * from sunrise_supermarket.customers;
select * from sunrise_supermarket.products;
select * from sunrise_supermarket.orders;
select * from sunrise_supermarket.order_items;

--Q14.Show every product priced above 100
select product_name,unit_price
from sunrise_supermarket.products p 
where p.unit_price >100;

--Q15.Show every customer NOT based in Nairobi
select full_name, city
from sunrise_supermarket.customers c 
where c.city <> 'Nairobi';

--Q16. Show every product priced between 60 and 200, inclusive
select product_name,unit_price
from sunrise_supermarket.products p 
where p.unit_price between 60 and 200;

--Q17. Show every customer who lives in Nairobi, Nakuru, or Mombasa, using IN.
select full_name, city
from sunrise_supermarket.customers c 
where city in ('Nairobi','Nakuru','Mombasa');

--Q18. Show every product whose name contains the word 'Oil', using LIKE.
select product_name
from sunrise_supermarket.products p 
where p.product_name ilike '%oil%';

--Q19. Show every order that is still 'Pending', sorted by order_date, earliest first.
select order_id
from sunrise_supermarket.orders o 
where status = 'Pending'
order by order_date desc ;

--Q20. Challenge - show the 2 most expensive products, using ORDER BY and LIMIT together.
select product_name, unit_price
from sunrise_supermarket.products p
order by p.unit_price desc
limit 2;
