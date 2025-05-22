select *
from menu_items;

-- Finding the number of items in the menu table
select count(*)
from menu_items;
-- Their are 32 items on the menu table

-- Finding the least expensive item on the table
select *
from menu_items
order by price;

-- Finding the most expensive item on the table
select *
from menu_items
order by price desc;

-- How many italian dishes are on the menu?
select category, count(*)
from menu_items
group by category; -- 9 Italian dishes

-- Least expensive american dish
select *
from menu_items
where category = 'American'
order by price; -- "Mac & Cheese" is the least expensive american dish

-- Average dish price in each category
select category, avg(price) as average_price
from menu_items
group by category
order by average_price;

-- Using the order_details table
select *
from order_details;

-- What is the date range of this table?
select order_date, count(*)
from order_details
group by order_date
order by order_date; -- Tells the full range and the count for each date

-- Or 

select min(order_date), max(order_date)
from order_details; -- Tells the min and max of range, cant be sure if all the dates are present

-- The number of orders made in this date range
select count(distinct(order_id)) as total_orders
from order_details; -- 5370 total orders were made in Janaury

-- Which orders have the most number of items?
select order_id, count(item_id)
from order_details
group by order_id
order by 2 desc; -- Most number of items were 14 in a single order

-- How many orders had more than 10 items?
select count(*)
from
(select order_id, count(item_id) as num_items
from order_details
group by order_id
having count(item_id) > 10) as num_orders; -- Subquery tells the number of items in orders(only greater than 10 items selected)
-- Main query counts the total number of such orders


-- Analyzing Customer Behavior by combining the two tables
select min(menu_item_id)
from menu_items;

select *
from order_details;


-- Join the two tables
select *
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
;

-- What were the least and most ordered items?
select item_name, category, count(*) as num_ordered
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
group by item_name, category
order by num_ordered;

-- What were the 5 orders that spent the most money?
select order_id, sum(price) as total_order_price
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
group by order_id
order by total_order_price desc
limit 5;

-- View the details of higehst spend order?
select order_id, sum(price) as total_order_price
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
group by order_id
order by total_order_price desc; -- Number 440

select *
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
where order_id = 440;

-- View the details of the top 5 orders.
select order_id, sum(price) as total_order_price
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
group by order_id
order by total_order_price desc;

select *, 
from order_details as od
left join menu_items as mi
	on od.item_id = mi.menu_item_id
where order_id in (440,2075,1957,330,2675);
	