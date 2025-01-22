//* Combined Exercises (Advanced)

10. **Total Sales by Category**  
   Calculate the total sales for each product category. Include the `category_name` and total sales amount.*/
SELECT * FROM products;
SELECT * FROM categories;
SELECT * FROM order_details;
SELECT * FROM orders;

SELECT categories.category_name,
   SUM(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) AS total_sales
FROM products
JOIN categories ON products.category_id = categories.category_id
JOIN order_details ON products.product_id = order_details.product_id
GROUP BY categories.category_name
ORDER BY total_sales DESC;

/* 11. **Employee with the Highest Sales**  
   Find the employee who generated the highest total sales. Use the `orders`, `order_details`, and `employees` tables.*/
SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM order_details;

SELECT employees.employee_id, employees.first_name, employees.last_name,
SUM(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) AS total_sales
FROM employees
JOIN orders ON employees.employee_id = orders.employee_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY employees.employee_id, employees.first_name, employees.last_name
ORDER BY total_sales DESC
LIMIT 1;

/* 12. **Supplier Contribution to Sales**  
   Calculate the total sales contributed by each supplier.*/
SELECT * FROM suppliers;
SELECT * FROM products;
SELECT * FROM order_details;
SELECT * FROM orders;

SELECT suppliers.supplier_id, suppliers.company_name,
SUM(order_details.unit_price * order_details.quantity * (1 - order_details.discount)) AS total_sales
FROM suppliers
JOIN products ON suppliers.supplier_id = products.supplier_id
JOIN order_details ON products.product_id = order_details.product_id
GROUP BY suppliers.supplier_id, suppliers.company_name
ORDER BY total_sales DESC;

/*13. **Customers with Most Orders in 1997**  
   Identify the customers who placed the most orders in 1997.*/
SELECT * FROM customers;
SELECT * FROM orders;

SELECT customers.customer_id, customers.contact_name, customers.company_name,
COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE DATE_TRUNC('year', order_date) = '1997-01-01'
GROUP BY customers.customer_id, customers.contact_name, customers.company_name
ORDER BY total_orders DESC
LIMIT 10;

/* Identify the customer who placed the most order for each and every year*/
WITH ranked_customers AS (
    SELECT c.customer_id, c.contact_name, c.company_name, 
           DATE_TRUNC('year', o.order_date) AS order_year, 
           COUNT(o.order_id) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY DATE_TRUNC('year', o.order_date) 
                              ORDER BY COUNT(o.order_id) DESC) AS rank
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.contact_name, c.company_name, DATE_TRUNC('year', o.order_date)
)
SELECT customer_id, contact_name, company_name, order_year, total_orders
FROM ranked_customers
WHERE rank = 1
ORDER BY order_year;


/*Explanation:
1- ROW_NUMBER() OVER (PARTITION BY DATE_TRUNC('year', o.order_date) ORDER BY COUNT(o.order_id) DESC):
This ranks the customers for each year based on the number of orders they placed, from highest to lowest.
The PARTITION BY ensures that the ranking starts over for each year.
2- WITH ranked_customers AS (...):
This Common Table Expression (CTE) calculates the ranking of customers within each year.
3- WHERE rank = 1:
This filters the results to only include the customer with the highest number of orders for each year.
