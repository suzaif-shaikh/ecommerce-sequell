-- =============================================================================================================================================================== --
#🟢 Basic Level
#1 Find customers who placed at least one order.
SELECT cu.* FROM customers AS cu WHERE cu.customer_id IN 
(SELECT o.customer_id FROM orders AS o ORDER BY cu.customer_id ASC ) ;

SELECT cu.* FROM customers AS cu WHERE EXISTS
(SELECT 1 FROM orders AS o WHERE o.customer_id = cu.customer_id ORDER by o.order_id ASC ) ;
-- =============================================================================================================================================================== --
#2 Find products whose price is greater than average product price.
SELECT pr1.* FROM products AS pr1 WHERE pr1.price > 
(SELECT ROUND(AVG(COALESCE(pr2.price,0)),2) AS `Average Product Price` FROM products AS pr2 ORDER BY pr2.product_id ASC );
-- =============================================================================================================================================================== --
#3 Find orders having total amount greater than average order amount.
SELECT o1.* FROM orders AS o1 WHERE o1.total_amount > 
(SELECT ROUND(AVG(COALESCE(o2.total_amount,0)),2) AS "Averrage Order Amount" FROM orders AS o2 ORDER BY o2.order_id ASC) ;
-- =============================================================================================================================================================== --
#4 Find customers who belong to the same city as customer 'Amit Sharma'.
SELECT cu1.* FROM customers AS cu1 WHERE cu1.city IN 
(SELECT cu2.city FROM  customers AS cu2 WHERE cu2.customer_name = "Amit Sharma" ORDER BY cu2.customer_id ASC );
-- =============================================================================================================================================================== --
#5 Find products with the maximum price.
SELECT pr1.* FROM products AS pr1 WHERE pr1.price =
(SELECT ROUND(MAX(COALESCE(pr2.price,0)),2) AS "Maximum Price" FROM products AS pr2 ORDER BY pr2.product_id); 
-- =============================================================================================================================================================== --
# 🟡 Intermediate Level
# 6 Find customers who never placed any order.
SELECT cu.* FROM customers AS cu WHERE cu.customer_id NOT IN 
(SELECT o.customer_id FROM orders AS o ORDER BY o.order_id ASC ) ; 

SELECT cu.* FROM customers AS cu WHERE NOT EXISTS 
(SELECT 1 FROM orders AS o ORDER BY o.order_id ASC ) ; 
-- =============================================================================================================================================================== --
#7 Find products that were never ordered.
SELECT pr.* FROM products AS pr WHERE NOT EXISTS
(SELECT 1 FROM order_items AS oi WHERE pr.product_id = oi.product_id ORDER BY oi.order_item_id ASC ) ; 
-- =============================================================================================================================================================== --
#8 Find orders whose payment amount is greater than average payment amount.
SELECT o.* FROM orders AS o WHERE o.order_id IN 
(SELECT p.order_id FROM payments AS p WHERE p.payment_amount > 
(SELECT AVG(payment_amount) FROM payments));
-- =============================================================================================================================================================== --
#9 Find categories having more products than average category product count.
SELECT ca.category_name , COUNT(*) AS product_count FROM categories AS ca 
INNER JOIN products AS pr ON ca.category_id = pr.category_id 
GROUP BY ca.category_name HAVING COUNT(*) > 
(SELECT AVG(product_count) FROM 
(SELECT COUNT(*) AS product_count FROM products AS pr
GROUP BY category_id ) AS category_counts ) ; 
-- =============================================================================================================================================================== --
#10 Find customers whose total spending is greater than average customer spending.
SELECT o.customer_id,
       SUM(o.total_amount) AS total_spending
FROM orders AS o
GROUP BY o.customer_id
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_spending)
    FROM (
        SELECT SUM(total_amount) AS customer_spending
        FROM orders
        GROUP BY customer_id
    ) AS spending
);

SELECT c.* , customer_totals.total_spending FROM customers AS c
JOIN (SELECT customer_id, SUM(total_amount) AS total_spending FROM orders GROUP BY customer_id
) AS customer_totals ON c.customer_id = customer_totals.customer_id
WHERE customer_totals.total_spending > (SELECT AVG(customer_spending)FROM (
SELECT SUM(total_amount) AS customer_spending FROM orders GROUP BY customer_id
) AS spending) ;
-- =============================================================================================================================================================== --
# 🔴 Advanced Level
# 11 Find products whose price is higher than every product in Clothing category.
SELECT 
    product_id,
    product_name,
    price
FROM products
WHERE price > ALL (
    SELECT price
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
    WHERE c.category_name = 'Clothing'
);
-- =============================================================================================================================================================== --
# 12 Find customers who placed the highest number of orders.
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(order_id) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS order_counts
);
-- =============================================================================================================================================================== --
#13 Find orders containing products with maximum quantity ordered.
SELECT DISTINCT
    oi.order_id,
    oi.product_id,
    oi.quantity
FROM order_items oi
WHERE oi.quantity = (
    SELECT MAX(quantity)
    FROM order_items
);
-- =============================================================================================================================================================== --
#14 Find categories generating revenue greater than average category revenue.
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.price) AS category_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
HAVING SUM(oi.quantity * oi.price) > (
    SELECT AVG(category_revenue)
    FROM (
        SELECT
            c2.category_id,
            SUM(oi2.quantity * oi2.price) AS category_revenue
        FROM categories c2
        JOIN products p2
            ON c2.category_id = p2.category_id
        JOIN order_items oi2
            ON p2.product_id = oi2.product_id
        GROUP BY c2.category_id
    ) AS category_sales
);
-- =============================================================================================================================================================== --
#15 Find products whose total sales quantity is greater than average sales quantity.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT
            product_id,
            SUM(quantity) AS total_quantity
        FROM order_items
        GROUP BY product_id
    ) AS product_sales
);
-- =============================================================================================================================================================== --
# 💀 Very Advanced
#16 Find customers who ordered all products from Electronics category.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM products p
    JOIN categories cat
        ON p.category_id = cat.category_id
    WHERE cat.category_name = 'Electronics'
      AND NOT EXISTS (
          SELECT 1
          FROM orders o
          JOIN order_items oi
              ON o.order_id = oi.order_id
          WHERE o.customer_id = c.customer_id
            AND oi.product_id = p.product_id
      )
);
-- =============================================================================================================================================================== --
#17 Find orders where total order amount is greater than the highest payment amount.
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT MAX(o2.total_amount)
    FROM orders o2
    JOIN payments p
        ON o2.order_id = p.order_id
);
-- =============================================================================================================================================================== --
#18 Find customers whose latest order amount is greater than their average order amount.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = c.customer_id
)
AND o.total_amount > (
    SELECT AVG(o3.total_amount)
    FROM orders o3
    WHERE o3.customer_id = c.customer_id
);
-- =============================================================================================================================================================== --
#19 Find products contributing more than 20% of total company revenue.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.price) AS product_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * oi.price) > (
    SELECT SUM(quantity * price) * 0.20
    FROM order_items
);
-- =============================================================================================================================================================== --
#20 Find cities whose total sales are greater than combined sales of Pune and Delhi.
SELECT
    c.city,
    SUM(o.total_amount) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > (
    SELECT SUM(o2.total_amount)
    FROM customers c2
    JOIN orders o2
        ON c2.customer_id = o2.customer_id
    WHERE c2.city IN ('Pune', 'Delhi')
);
-- =============================================================================================================================================================== --
-- 🟢 BASIC SUBQUERY QUESTIONS
-- 21. Find products whose price is greater than the average product price.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
-- =============================================================================================================================================================== --
-- 22. Find products whose price is equal to the maximum product price.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);
-- =============================================================================================================================================================== --
-- 23. Find products whose price is less than the minimum price of all products.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price < (
    SELECT MIN(price)
    FROM products
);
-- =============================================================================================================================================================== --
-- 24. Find customers who have placed at least one order.
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
-- =============================================================================================================================================================== --
-- 25. Find customers who have never placed an order.
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);
-- =============================================================================================================================================================== --
-- 🟡 INTERMEDIATE SUBQUERIES
-- 26. Find products belonging to the 'Mobile Phones' category.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE category_id = (
    SELECT category_id
    FROM categories
    WHERE category_name = 'Mobile Phones'
);
-- =============================================================================================================================================================== --
-- 7. Find products belonging to categories whose name contains 'Fashion'.
SELECT
    product_id,
    product_name,
    category_id
FROM products
WHERE category_id IN (
    SELECT category_id
    FROM categories
    WHERE category_name LIKE '%Fashion%'
);
-- =============================================================================================================================================================== --
-- 28. Find customers who live in cities where at least one order has been placed.
SELECT
    customer_id,
    customer_name,
    city
FROM customers
WHERE city IN (
    SELECT DISTINCT city
    FROM customers
    WHERE customer_id IN (
        SELECT customer_id
        FROM orders
    )
);
-- =============================================================================================================================================================== --
-- 29. Find orders whose amount is greater than the average order amount.
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);
-- =============================================================================================================================================================== --
-- 30. Find orders whose amount is equal to the highest order amount.
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);
-- =============================================================================================================================================================== --
-- 🟠 MULTI-ROW SUBQUERIES
-- 31. Find products whose price is greater than the price of every product in the Clothing category.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > ALL (
    SELECT p.price
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
    WHERE c.category_name = 'Clothing'
);
-- =============================================================================================================================================================== --
-- 32. Find products whose price is greater than at least one product in the Clothing category.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > ANY (
    SELECT p.price
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
    WHERE c.category_name = 'Clothing'
);
-- =============================================================================================================================================================== --
-- 33. Find products whose category belongs to Electronics, Mobile Phones, or Laptops.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE category_id IN (
    SELECT category_id
    FROM categories
    WHERE category_name IN (
        'Electronics',
        'Mobile Phones',
        'Laptops'
    )
);
-- =============================================================================================================================================================== --
-- 34. Find products whose category is NOT one of the fashion categories.
SELECT
    product_id,
    product_name,
    category_id
FROM products
WHERE category_id NOT IN (
    SELECT category_id
    FROM categories
    WHERE category_name LIKE '%Fashion%'
);
-- =============================================================================================================================================================== --
-- 35. Find customers who have placed orders worth more than ₹50,000.
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 50000
);
-- =============================================================================================================================================================== --
-- 🔵 SUBQUERY WITH EXISTS
-- 36. Find customers who have placed at least one order using EXISTS.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
-- =============================================================================================================================================================== --
V-- 37. Find customers who have never placed an order using NOT EXISTS.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
-- =============================================================================================================================================================== --
-- 38. Find products that have been ordered at least once.
SELECT
    p.product_id,
    p.product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);
-- =============================================================================================================================================================== --
-- 39. Find products that have never been ordered.
SELECT
    p.product_id,
    p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);
-- =============================================================================================================================================================== --
-- 40. Find customers who have at least one delivered order.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_status = 'Delivered'
);
-- =============================================================================================================================================================== --
-- 🔴 CORRELATED SUBQUERIES
-- 41. Find customers whose order amount is greater than their own average order amount.
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > (
    SELECT AVG(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);
-- =============================================================================================================================================================== --
-- 42. Find the highest-value order of each customer.
SELECT
    o.order_id,
    o.customer_id,
    o.total_amount
FROM orders o
WHERE o.total_amount = (
    SELECT MAX(o2.total_amount)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);
-- =============================================================================================================================================================== --
-- 43. Find customers whose latest order amount is greater than their average order amount.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = c.customer_id
)
AND o.total_amount > (
    SELECT AVG(o3.total_amount)
    FROM orders o3
    WHERE o3.customer_id = c.customer_id
);
-- =============================================================================================================================================================== --
-- 44. Find products whose price is greater than the average price of their own category.
SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);
-- =============================================================================================================================================================== --
-- 45. Find products whose price is the highest within their category.
SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);
-- =============================================================================================================================================================== --
-- 💀 ADVANCED SUBQUERIES
-- 46. Find the customer(s) who placed the highest number of orders.
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT
            customer_id,
            COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_orders
);
-- =============================================================================================================================================================== --
-- 47. Find categories whose revenue is greater than the average category revenue.
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.price) AS revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
HAVING SUM(oi.quantity * oi.price) > (
    SELECT AVG(category_revenue)
    FROM (
        SELECT
            p2.category_id,
            SUM(oi2.quantity * oi2.price) AS category_revenue
        FROM products p2
        JOIN order_items oi2
            ON p2.product_id = oi2.product_id
        GROUP BY p2.category_id
    ) AS category_sales
);
-- =============================================================================================================================================================== --
-- 48. Find products whose total quantity sold is greater than the average product quantity sold.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT
            product_id,
            SUM(quantity) AS total_quantity
        FROM order_items
        GROUP BY product_id
    ) AS product_sales
);
-- =============================================================================================================================================================== --

-- 49. Find customers who ordered every product in the Electronics category.
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM products p
    JOIN categories cat
        ON p.category_id = cat.category_id
    WHERE cat.category_name = 'Electronics'
      AND NOT EXISTS (
          SELECT 1
          FROM orders o
          JOIN order_items oi
              ON o.order_id = oi.order_id
          WHERE o.customer_id = c.customer_id
            AND oi.product_id = p.product_id
      )
);
-- =============================================================================================================================================================== --
-- 50. Find products contributing more than 20% of total company revenue.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.price) AS product_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * oi.price) > (
    SELECT SUM(quantity * price) * 0.20
    FROM order_items
);
-- =============================================================================================================================================================== --
