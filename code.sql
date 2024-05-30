1. Retrieve the Total Number of orders placed. 

SELECT COUNT( DISTINCT order_id) AS Total_orders FROM orders;




2. Calculate the total revenue generated from pizza sales.

SELECT ROUND(SUM(o.quantity * p.price),2) AS Total_revenue FROM pizzas p
JOIN order_details o ON p.pizza_id = o.pizza_id



3. Identify the highest-priced pizza.

SELECT pizza_types.name, pizzas.price FROM pizzas 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC;
limit 1;





4. Identify the most common pizza size ordered.

SELECT pizzas.size, COUNT(order_details.order_details_id) AS Total_orders FROM pizzas 
JOIN order_details  ON pizzas.pizza_id = order_details.pizza_id 
GROUP BY pizzas.size ORDER BY Total_orders DESC; 



5. List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name, SUM(order_details.quantity) AS Quantity FROM pizza_types
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC 
LIMIT 5;



6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(order_details.quantity) AS Total_quantity FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id 
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category;

7. Determine the distribution of orders by hour of the day.

SELECT hour(time) AS hour, COUNT(order_id) AS Total_orders FROM orders
GROUP BY hour 
ORDER BY hour ASC;

Orders are High between 12 PM - 7 PM.

8. find the category-wise distribution of pizzas.

SELECT category, COUNT(name) FROM pizza_types
GROUP BY category;





9. Determine the top 3 most ordered pizza types based on revenue.

SELECT pt.name, ROUND(SUM(o.quantity * p.price),2) AS Total_revenue FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id 
JOIN order_details o ON p.pizza_id = o.pizza_id
GROUP BY pt.name 
ORDER BY Total_revenue DESC
LIMIT 3;


10. Calculate the percentage contribution of each pizza type to total revenue

SELECT 
    pt.category, ROUND(SUM(od.quantity * p.price) / (
            SELECT SUM(od_inner.quantity * p_inner.price) FROM order_details od_inner
            JOIN pizzas p_inner ON p_inner.pizza_id = od_inner.pizza_id) * 100, 2) AS Revenue_Percentage
FROM pizza_types pt
JOIN  pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN  order_details od ON p.pizza_id = od.pizza_id
GROUP BY  pt.category
ORDER BY Revenue_Percentage DESC;




