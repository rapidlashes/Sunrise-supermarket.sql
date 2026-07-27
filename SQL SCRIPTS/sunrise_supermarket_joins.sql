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
select c.full_name, p.product_name, sum(oi.quantity) as total_quantity
from sunrise_supermarket.customers c 
inner join sunrise_supermarket.orders o on c.customer_id = o.customer_id 
inner join sunrise_supermarket.order_items oi on o.order_id = oi.order_id 
inner join sunrise_supermarket.products p on p.product_id =oi.product_id 
group by p.product_name,c.full_name ;