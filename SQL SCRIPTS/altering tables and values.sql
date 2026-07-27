


--SECTION B(ALTERING AND CHANGING TABLES/VALUE)

select * from sunrise_supermarket.customers;
select * from sunrise_supermarket.products;
select * from sunrise_supermarket.orders;
select * from sunrise_supermarket.order_items;

--Q5.renaming stock column to stock quantity
alter table sunrise_supermarket.products
rename column stock to stock_quantity;

--Q6.adding column called (loyalty points), and setting values to 0
alter table sunrise_supermarket.customers
add column loyalty_points int;

update sunrise_supermarket.customers
set loyalty_points = case customer_id
when 1 then 0
when 2 then 0
when 3 then 0
when 4 then 0
else loyalty_points
end;

--Q7.alter table sunrise_supermarket.products
alter column product_name type VARCHAR(150);

--Q12.updating status for order_id 2
update sunrise_supermarket.orders
set status = 'Delivered'
where order_id =2;

--Q13.Delete the cancelled order (order_id 4) 
delete from sunrise_supermarket.orders 
where status = 'Cancelled';

