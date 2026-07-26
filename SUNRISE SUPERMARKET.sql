--SECTION A(CREATING SCHEMA AND TABLES/INSERTING VALUES INTO THE TABLES)

select * from sunrise_supermarket.customers;
select * from sunrise_supermarket.products;
select * from sunrise_supermarket.orders;
select * from sunrise_supermarket.order_items;

create schema sunrise_supermarket;
set search_path to sunrise_supermarket;
create table sunrise_supermarket.customers(
customer_id serial primary key,
full_name VARCHAR(50) not null,
email VARCHAR(50) not null unique,
phone_number char(20) not null unique,
city varchar(50) not null
);

insert into sunrise_supermarket.customers(full_name, email, phone_number, city)
values
('Grace Wambui','grace.wambui@gmail.com','0711223344','Nairobi'),
('Kevin Mutiso','kevin.mutison@gmail.com','0722334455','Nakuru'),
('Faith Chebet','faith.chebet@gmail.com','0733445566','Eldoret'),
('Ibrahim Noor','ibrahim.noor@gmail.com','0744556677','Mombasa');

create table sunrise_supermarket.products(
product_id serial primary key,
product_name VARCHAR(50) not null,
category VARCHAR(50) not null,
unit_price DECIMAL(20,2),
stock INT
);
insert into sunrise_supermarket.products(product_name, category, unit_price, stock)
values
('Maize flour 2kg','Groceries',180.00,50),
('Cooking oil 1L','Groceries',320.00,30),
('Bathing soap','Toileteries',85.00,100),
('Notebook A4','Stationeries',60.00,200);

create table sunrise_supermarket.orders(
order_id serial primary key,
customer_id int not null references sunrise_supermarket.customers(customer_id),
order_date VARCHAR(50) not null,
status VARCHAR(50) 
);
insert into sunrise_supermarket.orders(customer_id, order_date, status)
values
(1,'2024-03-01','Delivered'),
(2,'2024-03-02','Pending'),
(1,'2024-03-03','Delivered'),
(3,'2024-03-04','Cancelled');

create table sunrise_supermarket.order_items(
order_item_id serial primary key,
order_id int not null references sunrise_supermarket.orders(order_id),
product_id int not null references sunrise_supermarket.products(product_id),
quantity int 
);

insert into sunrise_supermarket.order_items(order_id,product_id,quantity)
values 
(1,1,2),
(1,3,1),
(2,2,1),
(3,4,5);








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







--SECTION D(GROUPING AND  AGGREGATES)

select * from sunrise_supermarket.customers;
select * from sunrise_supermarket.products;
select * from sunrise_supermarket.orders;
select * from sunrise_supermarket.order_items;

--Q21. Count how many orders each customer_id has placed (GROUP BY customer_id).
select customer_id, count(order_id) as no_of_orders
from sunrise_supermarket.orders o 
group by o.customer_id 
order by o.customer_id asc ;

--Q22. using HAVING, show only the customer_id values that have placed more than 1 order.
select customer_id, count(order_id) as no_of_orders
from sunrise_supermarket.orders o 
group by o.customer_id 
having count(order_id) > 1
order by o.customer_id asc ;






--SECTION E(JOINS)

select * from sunrise_supermarket.customers;
select * from sunrise_supermarket.products;
select * from sunrise_supermarket.orders;
select * from sunrise_supermarket.order_items;

--Q23. INNER JOIN customers with orders to show each customer's full_name next to their order_id and status.
select c.full_name, o.order_id, o.status
from sunrise_supermarket.customers c 
inner join sunrise_supermarket.orders o on c.customer_id = o.customer_id ;

--Q24. LEFT JOIN orders with order_items so that every order shows up - even ones with no items. What do you notice about order_id 4 before you deleted it?
select o.order_id,oi.order_item_id
from sunrise_supermarket.orders o 
left join sunrise_supermarket.order_items oi on o.order_id = oi.order_id ;

--Q25. JOIN order_items with products to show, for every order item, the product_name and quantity together.
select oi.order_item_id, p.product_name, oi.quantity
from sunrise_supermarket.order_items oi 
left join sunrise_supermarket.products p on oi.product_id = p.product_id ;

--Q26.join all four tables together (customers → orders → order_items → products) to produce one row per item ordered, showing: full_name, order_id, product_name, quantity.
select c.full_name, o.order_id, p.product_name, oi.quantity
from sunrise_supermarket.customers c 
left join sunrise_supermarket.orders o on c.customer_id = o.customer_id 
inner join sunrise_supermarket.order_items oi on o.order_id = oi.order_id 
inner join sunrise_supermarket.products p on p.product_id =oi.product_id ;

--Q27.using your 4-table JOIN from Task 26, add a GROUP BY to show total quantity ordered per product_name across all customers
select c.full_name, p.product_name, count(oi.quantity) as orders_placed
from sunrise_supermarket.customers c 
inner join sunrise_supermarket.orders o on c.customer_id = o.customer_id 
inner join sunrise_supermarket.order_items oi on o.order_id = oi.order_id 
inner join sunrise_supermarket.products p on p.product_id =oi.product_id 
group by p.product_name,c.full_name ;