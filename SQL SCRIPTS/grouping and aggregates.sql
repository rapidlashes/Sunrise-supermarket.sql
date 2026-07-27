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
