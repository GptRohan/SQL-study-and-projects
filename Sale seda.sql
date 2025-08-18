-- Sales DB EDA Queries

-- 1. total sales
SELECT SUM(amount) AS total_sales FROM sales;

-- 2. total customers
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM sales;

-- 3. sales by product
SELECT product_id, SUM(amount) AS product_sales
FROM sales
GROUP BY product_id
ORDER BY product_sales DESC
LIMIT 5;

-- 4. sales by region
SELECT region, SUM(amount) AS region_sales
FROM sales
GROUP BY region
ORDER BY region_sales DESC;

-- 5. top customers
SELECT customer_id, SUM(amount) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 6. avg order value
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT order_id, SUM(amount) AS order_total
    FROM sales
    GROUP BY order_id
) t;

-- 7. monthly sales trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(amount) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;

-- 8. daily sales trend
SELECT order_date, SUM(amount) AS daily_sales
FROM sales
GROUP BY order_date
ORDER BY order_date;

-- 9. sales by payment method
SELECT payment_method, SUM(amount) AS method_sales
FROM sales
GROUP BY payment_method
ORDER BY method_sales DESC;

-- 10. repeat customers
SELECT customer_id, COUNT(DISTINCT order_id) AS orders_count
FROM sales
GROUP BY customer_id
HAVING orders_count > 1
ORDER BY orders_count DESC;