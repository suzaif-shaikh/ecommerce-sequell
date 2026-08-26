-- =============================================================================================================================================================== --
-- 1. Display all orders with a row number ordered by order date.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (ORDER BY order_date, order_id) AS row_num
FROM `orders`;
-- =============================================================================================================================================================== --
-- 2. Assign row numbers to orders based on highest order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (ORDER BY total_amount DESC, order_id) AS row_num
FROM `orders`;
-- =============================================================================================================================================================== --
-- 3. Rank orders based on total amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    RANK() OVER (ORDER BY total_amount DESC) AS order_rank
FROM `orders`;
-- =============================================================================================================================================================== --
-- 4. Dense-rank orders based on total amount without gaps.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    DENSE_RANK() OVER (ORDER BY total_amount DESC) AS order_rank
FROM `orders`;
-- =============================================================================================================================================================== --
-- 5. Divide orders into 4 groups based on total amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    NTILE(4) OVER (ORDER BY total_amount DESC, order_id) AS amount_group
FROM `orders`;
-- =============================================================================================================================================================== --
-- 6. Display the previous order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS previous_order_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 7. Display the next order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS next_order_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 8. Find the difference between current order amount and the previous order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS amount_difference
FROM `orders`;


-- =============================================================================================================================================================== --
-- 9. Calculate the running total of order amounts.
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM `orders`;
-- =============================================================================================================================================================== --
-- 10. Calculate the running average of order amounts.
SELECT
    order_id,
    order_date,
    total_amount,
    ROUND(
        AVG(total_amount) OVER (
            ORDER BY order_date, order_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS running_average
FROM `orders`;
-- =============================================================================================================================================================== --
-- 11. Find the cumulative maximum order amount.
SELECT
    order_id,
    order_date,
    total_amount,
    MAX(total_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_max_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 12. Find the cumulative minimum order amount.
SELECT
    order_id,
    order_date,
    total_amount,
    MIN(total_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_min_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 13. Display the total order amount using a window function.
SELECT
    order_id,
    customer_id,
    total_amount,
    SUM(total_amount) OVER () AS total_sales
FROM `orders`;
-- ================================================================================================================================================================ --
-- 14. Display the average order amount using a window function.
SELECT
    order_id,
    customer_id,
    total_amount,
    ROUND(AVG(total_amount) OVER (), 2) AS average_order_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 15. Display each customer's total order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
    ) AS customer_total_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 16. Display each customer's average order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROUND(
        AVG(total_amount) OVER (PARTITION BY customer_id),
        2
    ) AS customer_average_amount
FROM `orders`;
-- =============================================================================================================================================================== --
-- 17. Display the highest order amount for each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    MAX(total_amount) OVER (
        PARTITION BY customer_id
    ) AS customer_max_order
FROM `orders`;
-- =============================================================================================================================================================== --
-- 18. Rank orders by amount within each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    RANK() OVER (
        PARTITION BY customer_id
        ORDER BY total_amount DESC
    ) AS customer_order_rank
FROM `orders`;
-- =============================================================================================================================================================== --
-- 19. Dense-rank orders by amount within each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    DENSE_RANK() OVER (
        PARTITION BY customer_id
        ORDER BY total_amount DESC
    ) AS customer_order_rank
FROM `orders`;
-- =============================================================================================================================================================== --
-- 20. Assign row numbers to orders within each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS customer_order_number
FROM `orders`;
-- =============================================================================================================================================================== --
-- 21. Calculate each order's percentage of the customer's total spending.
SELECT
    order_id,
    customer_id,
    total_amount,
    ROUND(
        total_amount * 100.0 /
        NULLIF(SUM(total_amount) OVER (PARTITION BY customer_id), 0),
        2
    ) AS customer_sales_percentage
FROM `orders`;
-- =============================================================================================================================================================== --
-- 22. Find the highest-value order for each customer. Ties are included.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        RANK() OVER (
            PARTITION BY customer_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM `orders`
) AS ranked_orders
WHERE order_rank = 1;
-- =============================================================================================================================================================== --
-- 23. Find the second-highest-value order for each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM `orders`
) AS ranked_orders
WHERE order_rank = 2;
-- =============================================================================================================================================================== --
-- 24. Find the top 3 highest-value orders for each customer.
--     Exactly 3 rows per customer when at least 3 orders exist.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY total_amount DESC, order_id
        ) AS order_rank
    FROM `orders`
) AS ranked_orders
WHERE order_rank <= 3;
-- =============================================================================================================================================================== --
-- 25. Find orders whose amount is greater than the customer's
--     average order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    customer_average
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        AVG(total_amount) OVER (
            PARTITION BY customer_id
        ) AS customer_average
    FROM `orders`
) AS order_data
WHERE total_amount > customer_average;
-- =============================================================================================================================================================== --
-- 26. Find the lowest-value order for each customer.
--     Ties are included.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        RANK() OVER (
            PARTITION BY customer_id
            ORDER BY total_amount ASC
        ) AS order_rank
    FROM `orders`
) AS ranked_orders
WHERE order_rank = 1;
-- =============================================================================================================================================================== --
-- 27. Rank orders within each year by total amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    RANK() OVER (
        PARTITION BY YEAR(order_date)
        ORDER BY total_amount DESC
    ) AS yearly_order_rank
FROM `orders`;
-- =============================================================================================================================================================== --
-- 28. Calculate the running order count for each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS running_order_count
FROM `orders`;
-- =============================================================================================================================================================== --
-- 29. Find the number of days between a customer's current
--     order and previous order.
SELECT
    order_id,
    customer_id,
    order_date,
    previous_order_date,
    DATEDIFF(order_date, previous_order_date) AS days_since_previous_order
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS previous_order_date
    FROM `orders`
) AS customer_orders;
-- =============================================================================================================================================================== --
-- 30. Find the number of days until a customer's next order.
SELECT
    order_id,
    customer_id,
    order_date,
    next_order_date,
    DATEDIFF(next_order_date, order_date) AS days_until_next_order
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        LEAD(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS next_order_date
    FROM `orders`
) AS customer_orders;
-- =============================================================================================================================================================== --
-- 31. Rank products by price within each category.
--     Uses the products and categories tables from the dataset.
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    RANK() OVER (
        PARTITION BY p.category_id
        ORDER BY p.price DESC
    ) AS category_price_rank
FROM products AS p
JOIN categories AS c
    ON p.category_id = c.category_id;
-- =============================================================================================================================================================== --
-- 32. Find the top 3 most expensive products in each category.
SELECT
    product_id,
    product_name,
    category_name,
    price
FROM (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.price,
        ROW_NUMBER() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC, p.product_id
        ) AS price_rank
    FROM products AS p
    JOIN categories AS c
        ON p.category_id = c.category_id
) AS ranked_products
WHERE price_rank <= 3;
-- =============================================================================================================================================================== --
-- 33. Find each product's price difference from the highest product price in its category.
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    MAX(p.price) OVER (
        PARTITION BY p.category_id
    ) - p.price AS difference_from_category_max
FROM products AS p
JOIN categories AS c
    ON p.category_id = c.category_id;
-- =============================================================================================================================================================== --
-- 34. Calculate the running total of sales by order date.
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM `orders`;
-- =============================================================================================================================================================== --
-- 35. Find the running total of order amounts.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER(
        ORDER BY order_date, order_id
    ) AS running_total
FROM orders;
-- =============================================================================================================================================================== --
-- 36. Find the running average of order amounts.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER(
        ORDER BY order_date, order_id
    ) AS running_average
FROM orders;
-- =============================================================================================================================================================== --
-- 37. Find each customer's running total of orders.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS customer_running_total
FROM orders;
-- =============================================================================================================================================================== --
-- 38. Find each customer's average order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER(
        PARTITION BY customer_id
    ) AS customer_average_order
FROM orders;
-- =============================================================================================================================================================== --
-- 39. Rank each customer's orders from highest to lowest amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    RANK() OVER(
        PARTITION BY customer_id
        ORDER BY total_amount DESC
    ) AS order_rank
FROM orders;
-- =============================================================================================================================================================== --
-- 40. Find the highest-value order for each customer.
SELECT *
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        RANK() OVER(
            PARTITION BY customer_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM orders
) AS ranked_orders
WHERE order_rank = 1;
-- =============================================================================================================================================================== --
-- 41. Find the latest order for each customer.
SELECT *
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS row_num
    FROM orders
) AS customer_orders
WHERE row_num = 1;
-- =============================================================================================================================================================== --
-- 42. Find the previous order amount for each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_amount
FROM orders;
-- =============================================================================================================================================================== --
-- 43. Find the next order amount for each customer.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS next_order_amount
FROM orders;
-- =============================================================================================================================================================== --
-- 44. Find the difference between current and previous order amount.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    total_amount -
    LAG(total_amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS amount_difference
FROM orders;
-- =============================================================================================================================================================== --
-- 45. Find the percentage contribution of each order to the customer's total orders.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROUND(
        total_amount * 100.0 /
        SUM(total_amount) OVER(PARTITION BY customer_id),
        2
    ) AS customer_order_percentage
FROM orders;
-- =============================================================================================================================================================== --
-- 46. Rank products based on price within each category.
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    RANK() OVER(
        PARTITION BY p.category_id
        ORDER BY p.price DESC
    ) AS price_rank
FROM products p
JOIN categories c
    ON p.category_id = c.category_id;
-- =============================================================================================================================================================== --
-- 47. Find the highest-priced product in each category.
SELECT *
FROM (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.price,
        RANK() OVER(
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS price_rank
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
) AS ranked_products
WHERE price_rank = 1;
-- =============================================================================================================================================================== --
-- 48. Find products whose price is greater than their category average price.
SELECT *
FROM (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.price,
        AVG(p.price) OVER(
            PARTITION BY p.category_id
        ) AS category_average_price
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
) AS product_data
WHERE price > category_average_price;
-- =============================================================================================================================================================== --
-- 49. Find the top 3 products by price in each category.
SELECT *
FROM (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.price,
        DENSE_RANK() OVER(
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS price_rank
    FROM products p
    JOIN categories c
        ON p.category_id = c.category_id
) AS ranked_products
WHERE price_rank <= 3;
-- =============================================================================================================================================================== --
-- 50. Find each product's percentage contribution to total product price.
SELECT
    product_id,
    product_name,
    price,
    ROUND(
        price * 100.0 / SUM(price) OVER(),
        2
    ) AS price_percentage
FROM products;
-- =============================================================================================================================================================== --
