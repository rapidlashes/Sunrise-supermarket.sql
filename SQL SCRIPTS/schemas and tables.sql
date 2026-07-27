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

create index flash
on  sunrise_supermarket.products (product_name, category, unit_price, stock_quantity);

create index flash_1
on sunrise_supermarket.orders(status,order_date);

alter table sunrise_supermarket.orders
alter column order_date type DATE
using order_date::DATE;


