--Запрос 1: Какова общая сумма всех завершенных заказов?
select SUM(order_items.quantity * order_items.unit_price)
from orders 
join order_items on orders.order_id = order_items.order_id 
where orders.status = 'completed';

--Запрос 2: Какие клиенты сделали более 1-го заказа? Выведите их имя и кол-во заказов
select customers.first_name, customers.last_name, count(orders.order_id) 
from customers 
join orders on customers.customer_id = orders.customer_id 
group by customers.customer_id, customers.first_name, customers.last_name 
having count(orders.order_id) > 1;

--Запрос 3: Какие товары имеют остаток на складе меньше 5?
select product_name, stock_quantity
from products 
where stock_quantity < 5;

--Запрос 4: Найдите самый популярный товар по количеству проданных единиц
select products.product_name, SUM(order_items.quantity) as total_sold
from order_items 
join products on order_items.product_id = products.product_id 
group by products.product_name 
order by total_sold desc 
limit 1;

--Запрос 5: Выведите список клиентов, зарегестрировавшихся в последний месяц
select first_name, last_name, registration_date
from customers 
where registration_date >= current_date - interval '1 month'; 

--Запрос 6: Напишите запрос, который выводит все заказы с общей стоимостью более 10 000 руб.
select orders.order_id, sum(order_items.quantity * order_items.unit_price)
from orders 
join order_items on orders.order_id = order_items.order_id 
group by orders.order_id
having sum(order_items.quantity * order_items.unit_price) > 10000;

--Запрос 7: Какие категории товаров приносят наибольшую выручку?
select products.category, sum(order_items.quantity * order_items.unit_price) as profit
from order_items 
join products on order_items.product_id = products.product_id 
group by products.category 
order by profit desc; 
