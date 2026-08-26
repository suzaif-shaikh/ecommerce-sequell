-- =============================================================================================================================================================== --
-- Q1. Count the number of customers in each city.
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city;
-- =============================================================================================================================================================== --
-- Q2. Count the number of products for each category ID.
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id;
-- =============================================================================================================================================================== --
-- Q3. Count the number of products for each brand ID.
SELECT brand_id, COUNT(*) AS product_count
FROM products
GROUP BY brand_id;
-- =============================================================================================================================================================== --
-- Q4. Find the number of orders for each order status.
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status;
-- =============================================================================================================================================================== --
-- Q5. Find the number of orders for each customer.
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
-- =============================================================================================================================================================== --
-- Q6. Find the number of shipments for each city.
SELECT city, COUNT(*) AS shipment_count
FROM shipping
GROUP BY city;
-- =============================================================================================================================================================== --
-- Q7. Find the number of shipments for each shipping status.
SELECT shipping_status, COUNT(*) AS shipment_count
FROM shipping
GROUP BY shipping_status;
-- =============================================================================================================================================================== --
-- Q8. Find the number of payments for each payment method.
SELECT payment_method, COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method;
-- =============================================================================================================================================================== --
-- Q9. Find the number of payments for each payment status.
SELECT payment_status, COUNT(*) AS payment_count
FROM payments
GROUP BY payment_status;
-- =============================================================================================================================================================== --
-- Q10. Find the number of order items for each product.
SELECT product_id, COUNT(*) AS order_item_count
FROM order_items
GROUP BY product_id;
-- =============================================================================================================================================================== --
-- Q11. Find the total quantity sold for each product.
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id;
-- =============================================================================================================================================================== --
-- Q12. Find the total quantity sold for each order.
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id;
-- =============================================================================================================================================================== --
-- Q13. Find the average product price for each brand.
SELECT brand_id, AVG(price) AS average_price
FROM products
GROUP BY brand_id;
-- =============================================================================================================================================================== --
-- Q14. Find the average product price for each category.
SELECT category_id, AVG(price) AS average_price
FROM products
GROUP BY category_id;
-- =============================================================================================================================================================== --
-- Q15. Find the total stock available for each category.
SELECT category_id, SUM(stock) AS total_stock
FROM products
GROUP BY category_id;
-- =============================================================================================================================================================== --
-- Q16. Find the total sales amount for each order status.
SELECT order_status, SUM(total_amount) AS total_sales
FROM orders
GROUP BY order_status;
-- =============================================================================================================================================================== --
-- Q17. Find the average order amount for each order status.
SELECT order_status, AVG(total_amount) AS average_order_amount
FROM orders
GROUP BY order_status;
-- =============================================================================================================================================================== --
-- Q18. Find the maximum order amount for each order status.
SELECT order_status, MAX(total_amount) AS maximum_order
FROM orders
GROUP BY order_status;
-- =============================================================================================================================================================== --
-- Q19. Find the minimum order amount for each order status.
SELECT order_status, MIN(total_amount) AS minimum_order
FROM orders
GROUP BY order_status;
-- =============================================================================================================================================================== --
-- Q20. Find the total sales generated by each customer.
SELECT customer_id, SUM(total_amount) AS total_sales
FROM orders
GROUP BY customer_id;
-- =============================================================================================================================================================== --
-- Q21. Find the average order value for each customer.
SELECT customer_id, AVG(total_amount) AS average_order_value
FROM orders
GROUP BY customer_id;
-- =============================================================================================================================================================== --
-- Q22. Find the highest order value for each customer.
SELECT customer_id, MAX(total_amount) AS highest_order
FROM orders
GROUP BY customer_id;
-- =============================================================================================================================================================== --
-- Q23. Find the lowest order value for each customer.
SELECT customer_id, MIN(total_amount) AS lowest_order
FROM orders
GROUP BY customer_id;
-- =============================================================================================================================================================== --
-- Q24. Find the total discount given for each product.
SELECT product_id, SUM(discount) AS total_discount
FROM order_items
GROUP BY product_id;
-- =============================================================================================================================================================== --
-- Q25. Find the average discount for each product.
SELECT product_id, AVG(discount) AS average_discount
FROM order_items
GROUP BY product_id;
-- =============================================================================================================================================================== --
-- Q26. Find cities having more than 10 customers.
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 10;
-- =============================================================================================================================================================== --
-- Q27. Find categories having more than 5 products.
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;
-- =============================================================================================================================================================== --
-- Q28. Find brands having more than 2 products.
SELECT brand_id, COUNT(*) AS product_count
FROM products
GROUP BY brand_id
HAVING COUNT(*) > 2;
-- =============================================================================================================================================================== --
-- Q29. Find customers who placed more than 2 orders.
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;
-- =============================================================================================================================================================== --
-- Q30. Find products that were ordered more than 2 times.
SELECT product_id, COUNT(*) AS order_count
FROM order_items
GROUP BY product_id
HAVING COUNT(*) > 2;
-- =============================================================================================================================================================== --
-- Q31. Find products whose total quantity sold is greater than 5.
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
HAVING SUM(quantity) > 5;
-- =============================================================================================================================================================== --
-- Q32. Find categories having total stock greater than 500.
SELECT category_id, SUM(stock) AS total_stock
FROM products
GROUP BY category_id
HAVING SUM(stock) > 500;
-- =============================================================================================================================================================== --
-- Q33. Find brands whose average product price is greater than ₹10,000.
SELECT brand_id, AVG(price) AS average_price
FROM products
GROUP BY brand_id
HAVING AVG(price) > 10000;
-- =============================================================================================================================================================== --
-- Q34. Find customers whose total purchase amount is greater than ₹50,000.
SELECT customer_id, SUM(total_amount) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 50000;
-- =============================================================================================================================================================== --
-- Q35. Find order statuses having total sales greater than ₹1,00,000.
SELECT order_status, SUM(total_amount) AS total_sales
FROM orders
GROUP BY order_status
HAVING SUM(total_amount) > 100000;
-- =============================================================================================================================================================== --
-- Q36. Find cities having more than 5 customers and at least 1 customer after 2023.
SELECT city,
       COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 5;
-- =============================================================================================================================================================== --
-- Q37. Find products having total quantity sold greater than 10 and average discount greater than 2%.
SELECT product_id,
       SUM(quantity) AS total_quantity,
       AVG(discount) AS average_discount
FROM order_items
GROUP BY product_id
HAVING SUM(quantity) > 10
   AND AVG(discount) > 2;
-- =============================================================================================================================================================== --
-- Q38. Find customers whose total purchase is greater than ₹1,00,000 and average order value is greater than ₹20,000.
SELECT customer_id,
       SUM(total_amount) AS total_purchase,
       AVG(total_amount) AS average_order_value
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 100000
   AND AVG(total_amount) > 20000;
-- =============================================================================================================================================================== --
-- Q39. Find categories having more than 3 products and total stock greater than 100.
SELECT category_id,
       COUNT(*) AS product_count,
       SUM(stock) AS total_stock
FROM products
GROUP BY category_id
HAVING COUNT(*) > 3
   AND SUM(stock) > 100;
-- =============================================================================================================================================================== --
-- Q40. Find brands having more than 2 products and average price greater than ₹5,000.
SELECT brand_id,
       COUNT(*) AS product_count,
       AVG(price) AS average_price
FROM products
GROUP BY brand_id
HAVING COUNT(*) > 2
   AND AVG(price) > 5000;
-- =============================================================================================================================================================== --
-- Q41. Find customers having at least 2 orders and total purchase greater than ₹30,000.
SELECT customer_id,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 2
   AND SUM(total_amount) > 30000;
-- =============================================================================================================================================================== --
-- Q42. Find products having more than 1 order item
       and total quantity greater than 3.
SELECT product_id,
       COUNT(*) AS order_count,
       SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
HAVING COUNT(*) > 1
   AND SUM(quantity) > 3;
-- =============================================================================================================================================================== --
-- Q43. Find payment methods used for more than 10 payments.
SELECT payment_method,
       COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method
HAVING COUNT(*) > 10;
-- =============================================================================================================================================================== --
-- Q44. Find shipping cities having more than 10 shipments and more than 5 delivered shipments. */
SELECT city,
       COUNT(*) AS total_shipments,
       SUM(CASE WHEN shipping_status = 'Delivered' THEN 1 ELSE 0 END)
       AS delivered_shipments
FROM shipping
GROUP BY city
HAVING COUNT(*) > 10
   AND SUM(CASE WHEN shipping_status = 'Delivered' THEN 1 ELSE 0 END) > 5;
-- =============================================================================================================================================================== --
-- Q45. Find order statuses having more than 5 orders and average order value greater than ₹10,000.
SELECT order_status,
       COUNT(*) AS order_count,
       AVG(total_amount) AS average_order_value
FROM orders
GROUP BY order_status
HAVING COUNT(*) > 5
   AND AVG(total_amount) > 10000;
-- =============================================================================================================================================================== --
-- Q46. Find the top-level product groups where the total stock is greater than 1,000 and average price is below ₹10,000.
SELECT category_id,
       SUM(stock) AS total_stock,
       AVG(price) AS average_price
FROM products
GROUP BY category_id
HAVING SUM(stock) > 1000
   AND AVG(price) < 10000;
-- =============================================================================================================================================================== --
-- Q47. Find customers who placed at least 3 orders with a total purchase value above ₹1,00,000.
SELECT customer_id,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 3
   AND SUM(total_amount) > 100000;
-- =============================================================================================================================================================== --
-- Q48. Find products where total quantity sold is above 5 and total discount given is greater than 10%.
SELECT product_id,
       SUM(quantity) AS total_quantity,
       SUM(discount) AS total_discount
FROM order_items
GROUP BY product_id
HAVING SUM(quantity) > 5
   AND SUM(discount) > 10;
-- =============================================================================================================================================================== --
-- Q49. Find order statuses where the total salesexceed ₹5,00,000 and average order value exceeds ₹20,000.
SELECT order_status,
       SUM(total_amount) AS total_sales,
       AVG(total_amount) AS average_order_value
FROM orders
GROUP BY order_status
HAVING SUM(total_amount) > 500000
   AND AVG(total_amount) > 20000;
-- =============================================================================================================================================================== --
-- Q50. Find each customer whose number of orders is at least 2, total purchase is above ₹50,000, and average order value is above ₹20,000.
SELECT customer_id,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_purchase,
       AVG(total_amount) AS average_order_value
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 2
   AND SUM(total_amount) > 50000
   AND AVG(total_amount) > 20000;
-- =============================================================================================================================================================== --
   