-- Pizza DB EDA Queries

-- 1. total orders
SELECT COUNT(*) AS total_orders FROM orders;

-- 2. total customers
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM orders;

-- 3. total revenue
SELECT SUM(price) AS total_revenue FROM order_details;

-- 4. most popular pizza
SELECT pizza_id, COUNT(*) AS times_ordered
FROM order_details
GROUP BY pizza_id
ORDER BY times_ordered DESC
LIMIT 5;

-- 5. top customers by spend
SELECT customer_id, SUM(price) AS total_spent
FROM orders o
JOIN order_details d ON o.order_id = d.order_id
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 6. revenue by pizza category
SELECT category, SUM(price) AS revenue
FROM pizzas p
JOIN order_details d ON p.pizza_id = d.pizza_id
GROUP BY category
ORDER BY revenue DESC;

-- 7. avg order value
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT o.order_id, SUM(d.price) AS order_total
    FROM orders o
    JOIN order_details d ON o.order_id = d.order_id
    GROUP BY o.order_id
) t;

-- 8. daily order trend
SELECT DATE(order_date) AS order_day, COUNT(*) AS total_orders
FROM orders
GROUP BY order_day
ORDER BY order_day;

-- 9. hourly order trend
SELECT HOUR(order_time) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- 10. best pizza size
SELECT size, SUM(price) AS revenue
FROM pizzas p
JOIN order_details d ON p.pizza_id = d.pizza_id
GROUP BY size
ORDER BY revenue DESC;
