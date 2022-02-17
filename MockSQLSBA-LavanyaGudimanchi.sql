
use mock_sba;

/* 1.Create a query to return all orders made by users with the first name of “Marion” */

select o.ORDER_ID, o.USER_ID , o.STORE_ID  
from orders o 
join users u 
on o.USER_ID =u.USER_ID
where u.FIRST_NAME like 'Marion%';


/*2. Create a query to select all users that have not made an order */


select *
from users 
where USER_ID not in (select distinct  user_id 
from orders);

/*3. Create a Query to select the names and prices of all items that have been part of 2 or 
more separate orders. */


select i.NAME , i.PRICE  from items i
where ITEM_ID in (
select ITEM_ID 
from order_items
group by ITEM_ID 
having count(order_id) > 1);


/*4. Create a query to return the Order Id, Item name, Item Price, and Quantity from orders 
made at stores in the city “New York”. Order by Order Id in ascending order. */

select oi.ORDER_ID, i.NAME, i.PRICE ,oi.QUANTITY 
from order_items oi 
join items i 
on i.ITEM_ID = oi.ITEM_ID 
join orders o 
on o.ORDER_ID = oi.ORDER_ID
join stores s 
on o.STORE_ID = s.STORE_ID 
where s.CITY = "New York"
order by o.ORDER_ID  ;

/*5. Your boss would like you to create a query that calculates the total revenue generated 
by each item. Revenue for an item can be found as (Item Price * Total Quantity 
Ordered). Please return the first column as ‘ITEM_NAME’ and the second column as 
‘REVENUE’ */
 

select i.NAME as "Item Name" , i.PRICE * sum(oi.QUANTITY) as "Revenue" 
from items i 
join order_items oi 
on oi.ITEM_ID = i.ITEM_ID 
group by oi.ITEM_ID ;

/*6. Create a query with the following output: 
a. Column 1 - Store Name 
 			i. The name of each store 
b. Column 2 - Order Quantity 
			i. The number of times an order has been made in this store 
c. Column 3 - Sales Figure 
			i. If the store has been involved in more than 3 orders, mark as ‘High’ 
			ii. If the store has been involved in less than 3 orders but more than 1 order, mark as ‘Medium’ 
			iii. If the store has been involved with 1 or less orders, mark as ‘Low’ 
d. Should be ordered by the Order Quantity in Descending Order   */

 
 select s.NAME as 'Store Name', count(o.ORDER_ID) as 'Order Quantity', 
 case  
 	when  count(o.ORDER_ID) > 3 then 'High'
 	when  count(o.ORDER_ID) <= 3  and count(o.ORDER_ID) > 1 then 'Medium'
 	when  count(o.ORDER_ID) <= 1 then 'Low'
 end as 'Sales Figure' 
 from orders o 
 join stores s 
 on o.STORE_ID = s.STORE_ID 
 group by o.STORE_ID 
 order by count(o.ORDER_ID) desc ; 


