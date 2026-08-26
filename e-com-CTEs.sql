-- =============================================================================================================================================================== --
-- 🟢 BASIC CTE QUESTIONS — 1 to 20
-- 1. Find all customers using a CTE.
WITH customer_data AS (
    SELECT *
    FROM customers
)
SELECT *
FROM customer_data;
-- =============================================================================================================================================================== --
-- 2. Find all products using a CTE.
WITH product_data AS (
    SELECT *
    FROM products
)
SELECT *
FROM product_data;
-- =============================================================================================================================================================== --
-- 3. Find products whose price is greater than ₹10,000.
WITH product_data AS (
    SELECT *
    FROM products
)
SELECT
    product_id,
    product_name,
    price
FROM product_data
WHERE price > 10000;
-- =============================================================================================================================================================== --
-- 4. Find customers from Pune.
WITH pune_customers AS (
    SELECT *
    FROM customers
    WHERE city = 'Pune'
)
SELECT *
FROM pune_customers;
-- =============================================================================================================================================================== --
-- 5. Find orders greater than the average order amount.
WITH avg_order AS (
    SELECT AVG(total_amount) AS average_amount
    FROM orders
)
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT average_amount
    FROM avg_order
);
-- =============================================================================================================================================================== --
-- 6. Find the maximum product price.
WITH max_price AS (
    SELECT MAX(price) AS highest_price
    FROM products
)
SELECT *
FROM max_price;
-- =============================================================================================================================================================== --
-- 7. Find the minimum product price.
WITH min_price AS (
    SELECT MIN(price) AS lowest_price
    FROM products
)
SELECT *
FROM min_price;
-- =============================================================================================================================================================== --
-- 8. Find the average product price.
WITH avg_price AS (
    SELECT AVG(price) AS average_price
    FROM products
)
SELECT *
FROM avg_price;
-- =============================================================================================================================================================== --
-- 9. Find products priced above the average product price.
WITH avg_price AS (
    SELECT AVG(price) AS average_price
    FROM products
)
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > (
    SELECT average_price
    FROM avg_price
);
-- =============================================================================================================================================================== --
-- 10. Find products priced below the average product price.
WITH avg_price AS (
    SELECT AVG(price) AS average_price
    FROM products
)
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price < (
    SELECT average_price
    FROM avg_price
);
-- =============================================================================================================================================================== --
-- 11. Count the total number of customers.
WITH customer_count AS (
    SELECT COUNT(*) AS total_customers
    FROM customers
)
SELECT *
FROM customer_count;
-- =============================================================================================================================================================== --
-- 12. Count the total number of products.
WITH product_count AS (
    SELECT COUNT(*) AS total_products
    FROM products
)
SELECT *
FROM product_count;
-- =============================================================================================================================================================== --
-- 13. Count orders for each customer.
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_orders;
-- =============================================================================================================================================================== --

-- 14. Find customers who placed more than one order.
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    order_count
FROM customer_orders
WHERE order_count > 1;
-- =============================================================================================================================================================== --
-- 15. Calculate total sales.
WITH total_sales AS (
    SELECT SUM(total_amount) AS total_revenue
    FROM orders
)
SELECT *
FROM total_sales;
-- =============================================================================================================================================================== --
-- 16. Calculate average order amount.
WITH order_average AS (
    SELECT AVG(total_amount) AS average_order_amount
    FROM orders
)
SELECT *
FROM order_average;
-- =============================================================================================================================================================== --
-- 17. Find the highest-value order.
WITH highest_order AS (
    SELECT MAX(total_amount) AS highest_amount
    FROM orders
)
SELECT
    o.order_id,
    o.customer_id,
    o.total_amount
FROM orders o
WHERE o.total_amount = (
    SELECT highest_amount
    FROM highest_order
);
-- =============================================================================================================================================================== --
-- 18. Find delivered orders.
WITH delivered_orders AS (
    SELECT *
    FROM orders
    WHERE order_status = 'Delivered'
)
SELECT *
FROM delivered_orders;
-- =============================================================================================================================================================== --
-- 19. Find pending orders.
WITH pending_orders AS (
    SELECT *
    FROM orders
    WHERE order_status = 'Pending'
)
SELECT *
FROM pending_orders;
-- =============================================================================================================================================================== --
-- 20. Find products with stock greater than 100.
WITH high_stock AS (
    SELECT *
    FROM products
    WHERE stock > 100
)
SELECT
    product_id,
    product_name,
    stock
FROM high_stock;
-- =============================================================================================================================================================== --
-- 🟡 BASIC → INTERMEDIATE CTE — 21 to 35
-- 21. Find total sales by customer.
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_sales;
-- =============================================================================================================================================================== --

-- 22. Find customer names with their total sales.
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    cs.total_sales
FROM customers c
JOIN customer_sales cs
    ON c.customer_id = cs.customer_id;
-- =============================================================================================================================================================== --
-- 23. Find customers whose total spending is greater than ₹50,000.
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    cs.total_spending
FROM customers c
JOIN customer_sales cs
    ON c.customer_id = cs.customer_id
WHERE cs.total_spending > 50000;
-- =============================================================================================================================================================== --
-- 24. Find total sales by city.
WITH city_sales AS (
    SELECT
        c.city,
        SUM(o.total_amount) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city
)
SELECT *
FROM city_sales;
-- =============================================================================================================================================================== --
-- 25. Find the city with the highest sales.
WITH city_sales AS (
    SELECT
        c.city,
        SUM(o.total_amount) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city
)
SELECT
    city,
    total_sales
FROM city_sales
WHERE total_sales = (
    SELECT MAX(total_sales)
    FROM city_sales
);
-- =============================================================================================================================================================== --
-- 26. Find the city with the lowest sales.
WITH city_sales AS (
    SELECT
        c.city,
        SUM(o.total_amount) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city
)
SELECT
    city,
    total_sales
FROM city_sales
WHERE total_sales = (
    SELECT MIN(total_sales)
    FROM city_sales
);
-- =============================================================================================================================================================== --
-- 27. Find total quantity sold for each product.
WITH product_quantity AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY product_id
)
SELECT *
FROM product_quantity;
-- =============================================================================================================================================================== --
-- 28. Find products with total quantity sold greater than 5.
WITH product_quantity AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    pq.total_quantity
FROM products p
JOIN product_quantity pq
    ON p.product_id = pq.product_id
WHERE pq.total_quantity > 5;
-- 29. Find total revenue for each product.
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(quantity * price) AS revenue
    FROM order_items
    GROUP BY product_id
)
SELECT *
FROM product_revenue;
-- =============================================================================================================================================================== --
-- 30. Find products generating revenue greater than ₹10,000.
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(quantity * price) AS revenue
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    pr.revenue
FROM products p
JOIN product_revenue pr
    ON p.product_id = pr.product_id
WHERE pr.revenue > 10000;
-- =============================================================================================================================================================== --
-- 31. Find total revenue by category.
WITH category_revenue AS (
    SELECT
        p.category_id,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category_id
)
SELECT
    c.category_id,
    c.category_name,
    cr.revenue
FROM categories c
JOIN category_revenue cr
    ON c.category_id = cr.category_id;
-- =============================================================================================================================================================== --
-- 32. Find the category generating the highest revenue.
WITH category_revenue AS (
    SELECT
        p.category_id,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category_id
)
SELECT
    c.category_id,
    c.category_name,
    cr.revenue
FROM categories c
JOIN category_revenue cr
    ON c.category_id = cr.category_id
WHERE cr.revenue = (
    SELECT MAX(revenue)
    FROM category_revenue
);
-- =============================================================================================================================================================== --
-- 33. Find the category generating the lowest revenue.
WITH category_revenue AS (
    SELECT
        p.category_id,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category_id
)
SELECT
    c.category_id,
    c.category_name,
    cr.revenue
FROM categories c
JOIN category_revenue cr
    ON c.category_id = cr.category_id
WHERE cr.revenue = (
    SELECT MIN(revenue)
    FROM category_revenue
);
-- =============================================================================================================================================================== --
-- 34. Find total sales by order status.
WITH status_sales AS (
    SELECT
        order_status,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY order_status
)
SELECT *
FROM status_sales;
-- =============================================================================================================================================================== --
-- 35. Find the number of orders by year.
WITH yearly_orders AS (
    SELECT
        YEAR(order_date) AS order_year,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY YEAR(order_date)
)
SELECT *
FROM yearly_orders
ORDER BY order_year;
-- 🟠 INTERMEDIATE CTE QUESTIONS — 36 to 50
-- 36. Find total sales by year.
WITH yearly_sales AS (
    SELECT
        YEAR(order_date) AS order_year,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY YEAR(order_date)
)
SELECT *
FROM yearly_sales
ORDER BY order_year;
-- =============================================================================================================================================================== --
-- 37. Find the year with the highest sales.
WITH yearly_sales AS (
    SELECT
        YEAR(order_date) AS order_year,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY YEAR(order_date)
)
SELECT
    order_year,
    total_sales
FROM yearly_sales
WHERE total_sales = (
    SELECT MAX(total_sales)
    FROM yearly_sales
);
-- =============================================================================================================================================================== --
-- 38. Find the average sales for each city.
WITH city_sales AS (
    SELECT
        c.city,
        AVG(o.total_amount) AS average_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city
)
SELECT *
FROM city_sales;
-- =============================================================================================================================================================== --
-- 39. Find cities whose sales are greater than the average city sales.
WITH city_sales AS (
    SELECT
        c.city,
        SUM(o.total_amount) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city
),
average_city_sales AS (
    SELECT AVG(total_sales) AS avg_sales
    FROM city_sales
)
SELECT
    cs.city,
    cs.total_sales
FROM city_sales cs
CROSS JOIN average_city_sales acs
WHERE cs.total_sales > acs.avg_sales;
-- =============================================================================================================================================================== --
-- 40. Find products whose revenue is greater than the average product revenue.
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(quantity * price) AS revenue
    FROM order_items
    GROUP BY product_id
),
average_revenue AS (
    SELECT AVG(revenue) AS avg_revenue
    FROM product_revenue
)
SELECT
    p.product_id,
    p.product_name,
    pr.revenue
FROM products p
JOIN product_revenue pr
    ON p.product_id = pr.product_id
CROSS JOIN average_revenue ar
WHERE pr.revenue > ar.avg_revenue;
-- =============================================================================================================================================================== --
-- 41. Find customers whose order count is greater than the average customer order count.
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
),
average_orders AS (
    SELECT AVG(order_count) AS avg_order_count
    FROM customer_orders
)
SELECT
    c.customer_id,
    c.customer_name,
    co.order_count
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
CROSS JOIN average_orders ao
WHERE co.order_count > ao.avg_order_count;
-- =============================================================================================================================================================== --
-- 42. Find the customer with the highest total spending.
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    cs.total_spending
FROM customers c
JOIN customer_sales cs
    ON c.customer_id = cs.customer_id
WHERE cs.total_spending = (
    SELECT MAX(total_spending)
    FROM customer_sales
);
-- =============================================================================================================================================================== --
-- 43. Find the product with the highest total quantity sold.
WITH product_quantity AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    pq.total_quantity
FROM products p
JOIN product_quantity pq
    ON p.product_id = pq.product_id
WHERE pq.total_quantity = (
    SELECT MAX(total_quantity)
    FROM product_quantity
);
-- =============================================================================================================================================================== --
-- 44. Find the product with the highest revenue.
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(quantity * price) AS revenue
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    pr.revenue
FROM products p
JOIN product_revenue pr
    ON p.product_id = pr.product_id
WHERE pr.revenue = (
    SELECT MAX(revenue)
    FROM product_revenue
);
-- =============================================================================================================================================================== --
-- 45. Find brands with products priced above ₹50,000.
WITH expensive_products AS (
    SELECT
        brand_id,
        product_id,
        product_name,
        price
    FROM products
    WHERE price > 50000
)
SELECT
    b.brand_id,
    b.brand_name,
    ep.product_name,
    ep.price
FROM brands b
JOIN expensive_products ep
    ON b.brand_id = ep.brand_id;
-- =============================================================================================================================================================== --
-- 46. Find categories having more than 2 products.
WITH category_products AS (
    SELECT
        category_id,
        COUNT(*) AS product_count
    FROM products
    GROUP BY category_id
)
SELECT
    c.category_id,
    c.category_name,
    cp.product_count
FROM categories c
JOIN category_products cp
    ON c.category_id = cp.category_id
WHERE cp.product_count > 2;
-- =============================================================================================================================================================== --
-- 47. Find brands having more than 2 products.
WITH brand_products AS (
    SELECT
        brand_id,
        COUNT(*) AS product_count
    FROM products
    GROUP BY brand_id
)
SELECT
    b.brand_id,
    b.brand_name,
    bp.product_count
FROM brands b
JOIN brand_products bp
    ON b.brand_id = bp.brand_id
WHERE bp.product_count > 2;
-- =============================================================================================================================================================== --
-- 48. Find customers who have both delivered and pending orders.
WITH customer_status AS (
    SELECT
        customer_id,
        MAX(order_status = 'Delivered') AS has_delivered,
        MAX(order_status = 'Pending') AS has_pending
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN customer_status cs
    ON c.customer_id = cs.customer_id
WHERE cs.has_delivered = 1
  AND cs.has_pending = 1;
-- =============================================================================================================================================================== --
-- 49. Find products that have been ordered and have stock greater than the average stock.
WITH average_stock AS (
    SELECT AVG(stock) AS avg_stock
    FROM products
),

ordered_products AS (
    SELECT DISTINCT product_id
    FROM order_items
)
SELECT
    p.product_id,
    p.product_name,
    p.stock
FROM products p
JOIN ordered_products op
    ON p.product_id = op.product_id
CROSS JOIN average_stock ast
WHERE p.stock > ast.avg_stock;
-- =============================================================================================================================================================== --
-- 50. Find the top 5 products by revenue.
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(quantity * price) AS revenue
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    pr.revenue
FROM products p
JOIN product_revenue pr
    ON p.product_id = pr.product_id
ORDER BY pr.revenue DESC
LIMIT 5;
-- =============================================================================================================================================================== --
