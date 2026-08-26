-- =============================================================================================================================================================== --
-- 1. Display customer names with their order dates using INNER JOIN between customers and orders.
-- Show customer name and order date columns only.
SELECT c.customer_name , o.order_date FROM customers AS c INNER JOIN orders AS o 
ON c.customer_id = o.customer_id ORDER BY c.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 2 Display customer names with their total order amounts.
# Use INNER JOIN between customers and orders tables.
SELECT cu.customer_name , o.total_amount FROM customers AS cu INNER JOIN orders AS o 
ON cu.customer_id = o.customer_id ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 3 Show all product names with their category names.
# Use INNER JOIN between products and categories.
SELECT p.product_name , ca.category_name FROM products AS p INNER JOIN categories AS ca
ON p.category_id = ca.category_id ORDER BY p.product_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 4 Display all products with their brand names.
# Use INNER JOIN between products and brands tables.
SELECT p.product_name , b.brand_name FROM products AS p INNER JOIN brands AS b 
ON p.brand_id = b.brand_id ORDER BY p.product_id ASC ;
-- =============================================================================================================================================================== --
#️⃣ 5 Show order IDs with their payment methods.
# Use INNER JOIN between orders and payments.
SELECT o.order_id , p.payment_method FROM orders AS o INNER JOIN payments AS p
ON o.order_id = p.order_id ORDER BY o.order_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 6 Display customer names along with shipping city.
# Use customers, orders, and shipping tables.
SELECT cu.customer_name , s.city FROM customers AS cu INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN shipping AS s ON s.shipping_id = o.shipping_id ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 7 Show product names with ordered quantity and price.
# Use INNER JOIN between products and order_items.
SELECT p.product_name , oi.quantity , oi.price FROM products AS p INNER JOIN order_items AS oi ON p.product_id = oi.product_id
INNER JOIN orders AS o ON o.order_id = oi.order_id ORDER BY p.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 8 Display customer name, order date, and payment status.
# Use customers, orders, and payments tables.
SELECT cu.customer_name , o.order_date , p.payment_status FROM customers AS cu INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN payments AS p ON p.order_id = o.order_id ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 9 Show product name with category name and brand name.
# Use products, categories, and brands tables.
SELECT p.product_name , ca.category_name , b.brand_name FROM products AS p INNER JOIN categories AS ca ON p.category_id = ca.category_id 
INNER JOIN brands AS b ON b.brand_id = p.brand_id ORDER BY p.product_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 10 Display all delivered orders with customer names.
# Filter records where order_status = 'Delivered'.
SELECT cu.customer_name , o.order_status FROM customers AS cu INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
WHERE o.order_status = "Delivered" ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 11 Show customers who used UPI as payment method.
# Use customers, orders, and payments tables.
SELECT cu.customer_name , p.payment_method FROM customers AS cu INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN payments AS p ON p.order_id = o.order_id WHERE p.payment_method = "UPI" ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 12 Display products whose stock is less than 50 with brand names.
# Use INNER JOIN between products and brands.
SELECT p.product_name , b.brand_name , p.stock FROM products AS p INNER JOIN brands AS b ON p.brand_id = b.brand_id 
WHERE p.stock < 50 ORDER BY b.brand_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 13 Show customer name, product name, quantity, and price.
# Use customers, orders, order_items, and products tables.
SELECT cu.customer_name , p.product_name , oi.quantity , oi.price FROM customers AS cu 
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS p ON p.product_id = oi.product_id ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 14 Display all orders shipped to Pune city.
# Use orders, shipping, and customers tables.
SELECT o.order_id , cu.customer_name , s.city FROM orders AS o INNER JOIN shipping AS s ON o.shipping_id = s.shipping_id
INNER JOIN customers AS cu ON cu.customer_id = o.customer_id WHERE s.city = "Pune" ORDER BY o.order_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 15 Show products that belong to Electronics category.
# Use INNER JOIN between products and categories.
SELECT p.product_name , ca.category_name FROM products AS p INNER JOIN categories AS ca 
ON p.category_id = ca.category_id WHERE ca.category_name = "Electronics" ORDER BY p.product_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 16 Display total spending of each customer.
# Use SUM(), GROUP BY, and INNER JOIN.
SELECT cu.customer_name , SUM(oi.price * oi.quantity) AS `Total Spending` FROM customers AS cu INNER JOIN orders AS o
ON cu.customer_id = o.customer_id INNER JOIN order_items AS oi ON o.order_id = oi.order_id GROUP BY cu.customer_name ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 17 Show top 5 highest order amounts with customer names.
# Use ORDER BY DESC and LIMIT.
SELECT cu.customer_name , o.total_amount FROM customers AS cu INNER JOIN orders AS O 
ON cu.customer_id = o.customer_id ORDER BY o.total_amount DESC LIMIT 5 ;
-- =============================================================================================================================================================== --
#️⃣ 18 Display category-wise total number of products.
# Use COUNT(), GROUP BY, and INNER JOIN.
SELECT ca.category_name , COUNT(p.product_name) AS `Count Products` FROM categories AS ca INNER JOIN products AS p 
ON ca.category_id = p.category_id GROUP BY ca.category_name ORDER BY ca.category_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 19 Show each customer with purchased product, payment method, and shipping status.
# Use multiple INNER JOINs on related tables.
SELECT c.customer_name , pr.product_name , p.payment_method , s.shipping_status FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN products AS pr ON oi.product_id = pr.product_id
INNER JOIN payments AS p ON o.order_id = p.order_id
INNER JOIN shipping AS s ON o.shipping_id = s.shipping_id
ORDER BY c.customer_name ASC;
-- =============================================================================================================================================================== --
#️⃣ 20 Display brand-wise total sales amount.
# Use SUM(price * quantity) with GROUP BY and INNER JOINs.
SELECT b.brand_name , SUM(oi.price * oi.quantity) AS `Total Sales Amount` FROM brands AS b
INNER JOIN products AS p ON b.brand_id = p.brand_id
INNER JOIN order_items AS oi ON p.product_id = oi.product_id
GROUP BY b.brand_name ORDER BY b.brand_name ASC;
-- =============================================================================================================================================================== --
#️⃣ 21 Display customer names, order IDs, product names, category names, and payment status by
# joining customers, orders, products, categories, and payments tables. Show only completed payments and sort by customer name.
SELECT cu.customer_name , o.order_id , pr.product_name , ca.category_name , p.payment_status FROM customers AS cu 
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id 
INNER JOIN categories AS ca ON pr.category_id = ca.category_id 
INNER JOIN payments AS p ON o.order_id = p.order_id 
WHERE p.payment_status = "Paid"
ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 22 Display customer names, cities, product names, and total amount (price × quantity) 
# using customers, orders, and products tables. Sort by highest total amount.
SELECT cu.customer_id , cu.customer_name , cu.city , pr.product_name , SUM(oi.price * oi.quantity) AS `Total Amount` FROM customers AS cu
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id 
GROUP BY cu.customer_id , cu.customer_name , cu.city , pr.product_name 
ORDER BY `Total Amount` DESC ;
-- =============================================================================================================================================================== --
#️⃣ 23 Display customer names with product names and order dates using customers, orders, and products tables. Show only products with price greater than 5000.
SELECT cu.customer_id , cu.customer_name , pr.product_name , pr.price , o.order_date FROM customers AS cu 
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id 
WHERE pr.price > 5000 ORDER BY cu.customer_id ASC ;
-- =============================================================================================================================================================== --
#️⃣ 24 Display customer names, email IDs, product names, quantities, and order dates by joining customers, orders, and products tables. 
# Sort by latest order date.SELECT cu.* FROM customers AS cu ;
SELECT cu.customer_id , cu.customer_name , cu.email , pr.product_name , oi.quantity , o.order_date FROM customers AS cu
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id 
ORDER BY o.order_date DESC ; 
-- =============================================================================================================================================================== --
#️⃣ 25 Display customer names, cities, product categories, quantities, and prices using customers, orders, and products tables. 
# Show only customers from Mumbai or Pune.SELECT cu.* FROM customers AS cu ;
SELECT cu.customer_id , cu.customer_name , cu.city , pr.product_name , ca.category_name , oi.quantity , oi.price FROM customers AS cu 
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id 
INNER JOIN categories AS ca ON pr.category_id = ca.category_id 
WHERE cu.city IN("Mumbai","Pune")
ORDER BY cu.customer_id ASC ; 

-- =============================================================================================================================================================== --
#️⃣ 26 Display customer names, product names, quantities, prices, and total bill amounts using customers, orders, and products tables.
# Show only orders where total amount is above 10000.SELECT cu.* FROM customers AS cu ;
SELECT cu.customer_id , cu.customer_name , pr.product_name , oi.quantity , 
oi.price , SUM(oi.quantity * oi.price) AS `Total Bill Amount` 
FROM customers AS cu INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id 
GROUP BY cu.customer_id , cu.customer_name , pr.product_name , oi.quantity , oi.price 
HAVING `Total Bill Amount` > 10000 
ORDER BY `Total Bill Amount` DESC ; 
-- =============================================================================================================================================================== --
#️⃣ 27 Display customer names, product names, order quantities, and order dates using customers, orders, and products tables.
# Show only orders placed after '2024-01-01'.
SELECT cu.customer_id , cu.customer_name , pr.product_name , oi.quantity , o.order_date FROM customers AS cu
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id
WHERE o.order_date > "2024-01-01"
ORDER BY o.order_date DESC ;
-- =============================================================================================================================================================== --
#️⃣ 28 Display customer names, product names, categories, and quantities using customers, orders, and products tables.
# Show only Electronics category products.
SELECT cu.customer_id , cu.customer_name ,  pr.product_name , ca.category_name , oi.quantity FROM customers AS cu 
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id
INNER JOIN categories AS ca ON pr.category_id = ca.category_id 
WHERE ca.category_name = "Electronics"
ORDER BY cu.customer_id ASC ;
-- =============================================================================================================================================================== --
#️⃣ 29 Display cities with total number of orders and total sales amount using customers, orders, and products tables.
# Group the results by city.
SELECT cu.city , COUNT(o.order_id) AS `Count Order`, SUM(oi.quantity * oi.price) AS `Total Sales Amount` FROM customers AS cu
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id
GROUP by cu.city ORDER BY `Total Sales Amount` DESC ;
-- =============================================================================================================================================================== --
#️⃣ 30 Display customer names, product names, quantities, prices, categories, and order dates using customers, orders, and products tables.
# Show only products where quantity is greater than 3 and sort by highest price.
SELECT cu.customer_id , cu.customer_name , pr.product_name , oi.quantity , oi.price , ca.category_name , o.order_date FROM customers AS cu
INNER JOIN orders AS o ON cu.customer_id = o.customer_id 
INNER JOIN order_items AS oi ON o.order_id = oi.order_id 
INNER JOIN products AS pr ON oi.product_id = pr.product_id
INNER JOIN categories AS ca ON pr.category_id = ca.category_id 
WHERE oi.quantity > 3 ORDER BY oi.price DESC ;
-- =============================================================================================================================================================== --
#️⃣ 31 Display all customers with their order dates using LEFT JOIN between customers and orders.
# Show customers even if they have not placed any orders.
SELECT cu.customer_name , o.order_date FROM customers AS cu LEFT JOIN orders AS o 
ON cu.customer_id = o.customer_id ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 32 Show all customers with their total order amounts using LEFT JOIN.
# Include customers who have no orders.
SELECT cu.customer_name , o.total_amount FROM customers AS cu 
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id ORDER BY customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 33 Display all categories with their product names.
# Show categories even if no products exist in them.
SELECT ca.category_name , pr.product_name FROM categories AS ca LEFT JOIN products AS pr 
ON ca.category_id = pr.category_id ORDER BY ca.category_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 34 Show all brands with their products using LEFT JOIN.
# Include brands that currently have no products.
SELECT b.brand_name , pr.product_name FROM brands AS b LEFT JOIN  products AS pr 
ON b.brand_id = pr.brand_id ORDER BY b.brand_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 35 Display all orders with their payment methods.
# Show orders even if payment details are missing.
SELECT o.order_id , p.payment_method FROM orders AS o LEFT JOIN payments AS p 
ON o.order_id = p.order_id ORDER BY order_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 36 Show all customers with shipping cities.
# Include customers whose orders are not shipped yet.
SELECT cu.customer_name , s.city FROM customers AS cu LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN shipping AS s ON o.shipping_id = s.shipping_id ORDER BY cu.customer_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 37 Display all products with ordered quantities using LEFT JOIN.
# Include products that were never ordered.
SELECT pr.product_name , oi.quantity FROM products AS pr LEFT JOIN order_items AS oi 
ON pr.product_id = oi.product_id ORDER BY pr.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 38 Show all customers with payment statuses.
# Include customers whose payments are pending or unavailable.
SELECT cu.customer_name , p.payment_status FROM customers AS cu 
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN payments AS p ON o.order_id = p.order_id 
AND p.payment_status IN("Pending","Unavailable") 
ORDER BY cu.customer_name ASC ;  

SELECT cu.customer_name , p.payment_status FROM customers AS cu 
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN payments AS p ON o.order_id = p.order_id 
AND p.payment_status = ("Pending") OR p.payment_status = ("Unavailable") 
ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 39 Display all products with category names and brand names.
# Include products even if category or brand data is missing.
SELECT pr.product_name , ca.category_name , b.brand_name FROM products AS pr 
LEFT JOIN categories AS ca ON pr.category_id = ca.category_id 
LEFT JOIN brands AS b ON pr.brand_id = b.brand_id 
ORDER BY pr.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 40 Show all customers with delivered order statuses.
# Include customers who never placed orders.
SELECT cu.customer_name , o.order_status FROM customers AS cu 
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
AND o.order_status = ("Delivered") ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 41 Display all payment methods used by customers.
# Include customers who never made payments.
SELECT cu.customer_name , p.payment_method FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN payments AS p ON o.order_id = p.order_id 
ORDER BY cu.customer_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 42 Show all brands with products whose stock is below 50.
# Include brands with no low-stock products.
SELECT b.brand_name , pr.product_name , pr.stock FROM brands AS b 
LEFT JOIN products AS pr ON b.brand_id = pr.brand_id 
AND pr.stock < 50 ORDER BY b.brand_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 43 Display customer names with purchased product names and quantities.
# Include customers who never purchased anything.
SELECT cu.customer_name , pr.product_name , oi.quantity FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id 
LEFT JOIN products AS pr ON oi.product_id = pr.product_id 
ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 44 Show all shipping cities with customer names and order IDs.
# Include shipping records not linked to customers.
SELECT  s.city , cu.customer_name , o.order_id FROM shipping AS s
LEFT JOIN orders AS o ON s.shipping_id = o.shipping_id
LEFT JOIN customers AS cu ON o.customer_id = cu.customer_id
ORDER BY s.city ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 45 Display all categories with Electronics products only.
# Include categories without Electronics products.
SELECT ca.category_name , pr.product_name FROM categories AS ca 
LEFT JOIN products AS pr ON ca.category_id = pr.category_id 
AND ca.category_name IN ("Electronics")
ORDER BY ca.category_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 46 Show total spending of each customer using LEFT JOIN and SUM().
# Include customers with zero spending.
SELECT cu.customer_name , SUM(oi.price * oi.quantity) AS `Total Spending` FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id 
GROUP BY cu.customer_name ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 47 Display top 5 customers by highest total order amount using LEFT JOIN.
# Include customers even if they have no orders.
SELECT cu.customer_name , COALESCE(SUM(o.total_amount),0) AS `Total_Spending` FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id
GROUP BY cu.customer_name ORDER BY `Total_Spending` DESC LIMIT 5 ;
-- ============================================================================================================================================================== --
#️⃣ 48 Show category-wise total number of products using LEFT JOIN.
# Include categories with zero products.
SELECT ca.category_name , COUNT(pr.product_id) `Total Product` FROM categories AS ca 
LEFT JOIN products AS pr ON ca.category_id = pr.category_id 
GROUP BY ca.category_name ORDER BY ca.category_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 49 Display each customer with purchased products, payment methods, and shipping status.
# Include customers who never placed orders.
SELECT cu.customer_name , pr.product_name , p.payment_method , s.shipping_status FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id 
LEFT JOIN products AS pr ON oi.product_id = pr.product_id 
LEFT JOIN shipping AS s ON o.shipping_id = s.shipping_id 
LEFT JOIN payments AS p ON o.order_id = p.order_id 
ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 50 Display brand-wise total sales amount using LEFT JOIN and GROUP BY.
# Include brands with zero sales.
SELECT b.brand_name , COALESCE(SUM(oi.price * oi.quantity),0) AS `Total Sales Amount` FROM brands AS b 
LEFT JOIN products AS pr ON b.brand_id = pr.brand_id 
LEFT JOIN order_items AS oi ON pr.product_id = oi.product_id
GROUP BY b.brand_name ORDER BY brand_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 51 Display all customers with total number of orders and total spending.
#Use LEFT JOIN, COUNT(), SUM(), and GROUP BY.
#Include customers who never placed orders.
SELECT cu.customer_name , COUNT(o.order_id) AS `Count Order` , COALESCE(SUM(oi.price * oi.quantity),0) AS `Total Spending` FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id 
GROUP BY cu.customer_name ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 52 Show all products with total ordered quantity and remaining stock.
#Use LEFT JOIN between products and order_items.
#Include products that were never ordered.
SELECT pr.product_name , COALESCE(SUM(oi.quantity),0) AS `Total Quantity` , pr.stock FROM products AS pr 
LEFT JOIN order_items AS oi ON pr.product_id =  oi.product_id 
GROUP BY pr.product_name , pr.stock ORDER BY pr.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 53 Display all categories with average product price.
#Use LEFT JOIN and AVG().
#Include categories with no products.
SELECT ca.category_name , COALESCE(AVG(pr.price),0) AS `Average Product` FROM categories AS ca 
LEFT JOIN products AS pr ON ca.category_id = pr.category_id
GROUP BY ca.category_name ORDER BY ca.category_name ;
-- =============================================================================================================================================================== --
#️⃣ 54 Show all brands with highest sold product quantity.
#Use LEFT JOIN, MAX(), and GROUP BY.
#Include brands with zero sales.
SELECT b.brand_name , COALESCE(MAX(oi.quantity),0) AS `Highest Quantity` FROM brands AS b 
LEFT JOIN products AS pr ON b.brand_id = pr.brand_id 
LEFT JOIN order_items AS oi ON pr.product_id = oi.product_id 
GROUP BY b.brand_name  ORDER BY `Highest Quantity` DESC ; 
-- =============================================================================================================================================================== --
#️⃣ 55 Display customers with their latest order date and payment method.
#Use LEFT JOIN, MAX(), and multiple joins.
#Include customers who never placed orders.
SELECT cu.customer_name , COALESCE(MAX(o.order_date),"No Orders") AS `Lastest Order Date` , p.payment_method FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id 
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id 
LEFT JOIN payments AS p ON o.order_id = p.order_id 
GROUP BY cu.customer_name , p.payment_method ORDER BY cu.customer_name ASC ;  
-- =============================================================================================================================================================== --
#️⃣ 56 Display all orders with customer names using RIGHT JOIN between customers and orders.
#Include orders even if customer details are missing.
SELECT cu.customer_name , o.order_id FROM orders AS o 
inner JOIN customers AS cu ON o.customer_id = cu.customer_id 
ORDER BY o.order_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 57 Show all payments with corresponding order dates using RIGHT JOIN.
#Include payments even if order records are unavailable.
SELECT p.payment_method , o.order_date FROM payments AS p 
RIGHT JOIN orders AS o ON p.order_id = o.order_id 
ORDER BY p.payment_ID ASC ;
-- =============================================================================================================================================================== --
#️⃣ 58 Display all products with their category names using RIGHT JOIN.
#Include products whose categories are missing.
SELECT pr.product_name , ca.category_name FROM products AS pr 
RIGHT JOIN categories AS ca ON pr.category_id = ca.category_id 
ORDER BY pr.product_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 59 Show all products with their brand names using RIGHT JOIN.
#Include products even if brand details are unavailable.
SELECT pr.product_name , b.brand_name FROM products AS pr
RIGHT JOIN brands AS b ON pr.brand_id = b.brand_id 
ORDER BY pr.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 60 Display all shipping records with customer names.
#Use RIGHT JOIN between customers, orders, and shipping.
#Include shipping records without customers.
SELECT cu.customer_name , s.city FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.order_id 
RIGHT JOIN shipping AS s ON o.shipping_id = s.shipping_id 
ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 61 Show all order items with product names and quantities.
#Include order items even if product details are missing.
SELECT pr.product_name , oi.quantity FROM products AS pr
RIGHT JOIN order_items AS oi ON pr.product_id = oi.product_id
ORDER BY oi.order_item_id ASC ;
-- =============================================================================================================================================================== --
#️⃣ 62 Display all payments with payment methods and customer names.
#Use RIGHT JOIN on customers, orders, and payments.
#Include payments without customers.
SELECT cu.customer_name , p.payment_method FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id 
RIGHT JOIN payments AS p ON o.order_id = p.order_id 
ORDER BY cu.customer_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 63 Show all orders with shipping cities.
#Include shipping records even if orders are unavailable.
SELECT o.order_id , s.city FROM orders AS o 
RIGHT JOIN shipping AS s ON o.shipping_id = s.shipping
ORDER BY o.order_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 64 Display all products with category names and brand names using RIGHT JOIN.
#Include products even if category or brand data is missing.
SELECT pr.product_name , ca.category_name , b.brand_name FROM categories AS ca 
RIGHT JOIN products AS pr ON ca.category_id = pr.category_id 
RIGHT JOIN brands AS b ON pr.product_id = b.brand_id 
ORDER BY pr.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 65 Show all payments with delivered order statuses.
#Include payments even if order status is unavailable.
SELECT p.payment_method , o.order_status FROM orders AS o
RIGHT JOIN payments AS p ON o.order_id = p.order_id 
AND o.order_status = "Delivered" ORDER BY p.payment_id ASC ;
-- =============================================================================================================================================================== --
#️⃣ 66 Display all order items with ordered product prices.
#Include order items even if product records are deleted.
SELECT oi.order_item_id , pr.price FROM order_items AS oi 
RIGHT JOIN products AS pr ON oi.product_id = pr.product_id 
ORDER BY oi.order_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 67 Show all shipping cities with payment methods.
#Use RIGHT JOIN between shipping, orders, and payments.
#Include payments without shipping records.
SELECT s.city , p.payment_method FROM shipping AS s 
RIGHT JOIN orders AS o ON s.shipping_id = o.shipping_id 
RIGHT JOIN payments AS p ON o.order_id = p.order_id
ORDER BY p.payment_id ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 68 Display all products with ordered quantities using RIGHT JOIN.
#Include order items whose products are unavailable.
SELECT pr.product_name , oi.quantity FROM products AS pr 
RIGHT JOIN order_items AS oi ON pr.product_id = oi.product_id 
ORDER BY pr.product_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 69 Show all orders with customer names and payment statuses.
#Include orders even if customer or payment details are missing.
SELECT o.order_id , cu.customer_name , p.payment_status FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id 
RIGHT JOIN payments AS p ON o.order_id = p.order_id 
ORDER BY o.order_id ASC ;
-- =============================================================================================================================================================== --
#️⃣ 70 Display all payments with shipping statuses.
#Use RIGHT JOIN between shipping and payments through orders.
#Include payments without shipping data.
SELECT p.payment_method , s.shipping_status FROM payments AS p
RIGHT JOIN orders AS o ON p.order_id = o.order_id 
RIGHT JOIN shipping AS s ON o.shipping_id  = s.shipping_id 
ORDER BY p.payment_method ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 71 Show payment-wise total transaction amount using RIGHT JOIN and SUM().
#Include payment methods with missing order details.
SELECT p.payment_method , SUM(COALESCE(o.total_amount,0)) AS `Total Transaction` FROM payments AS p 
RIGHT JOIN orders AS o ON p.order_id = o.order_id 
GROUP BY p.payment_method ORDER BY p.payment_method ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 72 Display product-wise total ordered quantity using RIGHT JOIN and GROUP BY.
#Include order items even if products are unavailable.
SELECT p.payment_method , SUM(COALESCE(oi.quantity,0)) AS `Total Quantity` FROM payments AS p 
RIGHT JOIN order_items AS oi ON p.order_id = oi.order_id 
GROUP BY p.payment_method ORDER BY p.payment_method ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 73 Show category-wise total products using RIGHT JOIN.
#Include products whose category data is missing.
SELECT ca.category_name , COUNT(pr.product_id) AS `Total Product` FROM categories AS ca
RIGHT JOIN products AS pr ON ca.category_id = pr.category_id 
GROUP BY ca.category_name ORDER BY ca.category_name ASC ; 
-- =============================================================================================================================================================== --
#️⃣ 74 Display customer names with latest payment dates using RIGHT JOIN and MAX().
#Include payments even if customer data is unavailable.
SELECT cu.customer_name , MAX(p.payment_date) AS `Latest Payment Date` FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id 
RIGHT JOIN payments AS p ON o.order_id = p.order_id 
GROUP BY cu.customer_name ORDER BY cu.customer_name ASC ;
-- =============================================================================================================================================================== --
#️⃣ 75 Show shipping-wise total delivered orders using RIGHT JOIN and COUNT().
# Include shipping records even if orders are unavailable.
SELECT s.city , COUNT(o.order_id) AS `Total Delivered Orders` FROM shipping AS s 
RIGHT JOIN orders AS o ON s.shipping_id = o.shipping_id 
AND o.order_status = "Delivered" 
GROUP BY s.city ORDER BY s.city ASC ; 
-- =============================================================================================================================================================== --
#🔴 Advanced RIGHT JOIN Questions
#76 Display all orders and their customer details using RIGHT JOIN.
#👉 Include orders even if customer information is missing.
SELECT cu.customer_id , cu.customer_name , o.order_id , o.order_date , o.total_amount FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id ORDER BY o.order_id ASC ; 
-- =============================================================================================================================================================== --
#77 Show all products and related order details using RIGHT JOIN.
#👉 Include products that were never ordered.
SELECT oi.order_item_id , oi.quantity , pr.product_id , pr.product_name , pr.price FROM order_items AS oi 
RIGHT JOIN products AS pr ON oi.product_id = pr.product_id ORDER BY oi.order_item_id ASC ; 
-- =============================================================================================================================================================== --
#78 Display all categories and their products using RIGHT JOIN.
#👉 Include categories with no products assigned.
SELECT ca.category_id , ca.category_name , pr.product_id , pr.product_name FROM categories AS ca 
RIGHT JOIN products AS pr ON ca.category_id = pr.category_id ORDER BY ca.category_id ASC ; 
-- =============================================================================================================================================================== --
#79 Show all payment records with customer names and order details using RIGHT JOIN.
#👉 Include payments even if orders are missing.
SELECT cu.customer_id , cu.customer_name , o.order_id , p.payment_id , p.payment_method , p.payment_status FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id RIGHT JOIN payments AS p ON o.order_id = p.order_id ORDER BY cu.customer_id ASC ;
-- =============================================================================================================================================================== --
#80 Display all shipping records with customer and order information.
#👉 Include shipments even if order data does not exist.
SELECT s.shipping_id , s.city , s.shipping_status , o.order_id , cu.customer_id , cu.customer_name FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id 
RIGHT JOIN shipping AS s ON o.shipping_id = s.shipping_id  ORDER BY s.shipping_id ASC ; 
-- =============================================================================================================================================================== --
#81 Show all products with: total quantity sold total revenue generated
#👉 Include products with zero sales.
SELECT pr.product_id , pr.product_name , SUM(COALESCE(oi.quantity,0)) AS `Total Quantity` , SUM(COALESCE(oi.price * oi.quantity,0)) AS `Total Revenue`
FROM products AS pr RIGHT JOIN order_items AS oi ON pr.product_id = oi.product_id GROUP BY pr.product_id , pr.product_name ORDER BY pr.product_id ASC ;
-- =============================================================================================================================================================== --
#82 Display all customers and their latest order date using RIGHT JOIN.
#👉 Include customers who never placed any order.
SELECT cu.customer_id , cu.customer_name , MAX(o.order_date) AS `Latest Order Date` FROM customers AS cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id GROUP BY cu.customer_id , cu.customer_name 
ORDER BY cu.customer_id ASC ; 
-- =============================================================================================================================================================== --
#83 Show all categories with: total number of products average product price
#👉 Include categories without products.
SELECT ca.category_id , ca.category_name , COUNT(pr.product_id) AS `Total Product` , AVG(pr.price) AS `Average Price` FROM products AS pr 
RIGHT JOIN categories AS ca ON ca.category_id = pr.category_id GROUP BY ca.category_id , ca.category_name ORDER BY ca.category_id ASC ;
-- =============================================================================================================================================================== --
#84 Display all orders with payment and shipping details using multiple RIGHT JOINs.
#👉 Include records even if payment or shipping data is missing.
SELECT o.order_id , p.payment_method , s.delivery_date , s.shipping_status FROM orders AS o 
RIGHT JOIN payments AS p ON o.order_id = p.order_id RIGHT JOIN shipping AS s ON o.shipping_id = s.shipping_id 
ORDER BY o.order_id ASC ;
-- =============================================================================================================================================================== --
#85 Show all products with: category name total orders count highest quantity ordered
#👉 Include products never ordered.
SELECT pr.product_id , pr.product_name , ca.category_name , COUNT(oi.order_id) AS `Total Orders` , MAX(oi.quantity) AS `Highest Quantity` FROM order_items AS oi
RIGHT JOIN products AS pr ON oi.product_id = pr.product_id RIGHT JOIN categories AS ca ON pr.category_id = ca.category_id 
GROUP BY pr.product_id , pr.product_name , ca.category_name ORDER BY pr.product_id ASC ;
-- =============================================================================================================================================================== --
#💀 Bonus Interview-Level Questions
#86 Display all customers and total spending.
#👉 Include customers with no orders.
SELECT cu.customer_id , cu.customer_name , o.order_id , SUM(COALESCE(oi.price * oi.quantity,0)) AS `Total Spending` FROM customers AS cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id LEFT JOIN order_items AS oi ON o.order_id = oi.order_id 
GROUP BY cu.customer_id , cu.customer_name , o.order_id ORDER BY cu.customer_id ASC ; 
-- =============================================================================================================================================================== --
#87 Show all categories and total revenue generated from their products.
#👉 Include categories with zero revenue.
SELECT ca.category_id , ca.category_name , SUM(COALESCE(oi.price * oi.quantity,0)) AS `Total Revenue` 
FROM order_items AS oi RIGHT JOIN products AS pr ON oi.product_id = pr.product_id 
RIGHT JOIN categories AS ca ON pr.category_id = ca.category_id GROUP BY ca.category_id , ca.category_name
ORDER BY ca.category_id ASC ; 
-- =============================================================================================================================================================== --
#88 Display all products with pending shipment count.
#👉 Include products never shipped.
SELECT pr.product_name , COUNT(s.shipping_id) AS `Pending Shipment Count` FROM products AS pr 
LEFT JOIN order_items AS oi ON pr.product_id = oi.product_id 
LEFT JOIN orders AS o ON oi.order_id = o.order_id 
LEFT JOIN shipping AS s ON o.shipping_id = s.shipping_id 
AND s.shipping_status = "Pending" 
GROUP BY pr.product_name ORDER BY pr.product_name ASC ;
-- =============================================================================================================================================================== --
#89 Show all payment methods and total transactions count.
#👉 Include methods with zero transactions.
SELECT p.payment_method , COUNT(p.payment_id) AS `Total Transaction Count` FROM payments AS p 
LEFT JOIN orders AS o ON p.order_id = o.order_id 
GROUP BY p.payment_method ORDER BY p.payment_method ASC ; 
-- =============================================================================================================================================================== --
#90 Display all cities and total delivered orders.
#👉 Include cities with no delivered orders.
SELECT s.city , COUNT(order_id) AS `Total Delivered Orders` FROM shipping AS s 
LEFT JOIN orders AS o ON s.shipping_id = o.shipping_id 
AND o.order_status = "Delivered" GROUP BY s.city ORDER BY s.city ASC ; 
-- =============================================================================================================================================================== --

