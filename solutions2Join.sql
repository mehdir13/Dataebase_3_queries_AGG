/*Join Exercises

5. **List All Orders with Customer Details**  
   Create a query that lists all orders along with the customer's `company_name` and `contact_name`.
   You can choose any number of columns to display from the order table.*/
SELECT * FROM orders;
SELECT * from customers;

SELECT order_id, customer_id, contact_name, order_date
FROM orders
NATURAL JOIN customers;

/* 6. **Employees and Territories**  
   Write a query to list all employees with the territories they manage.
   Use the `employees`, `employee_territories`, and `territories` tables.*/
SELECT * FROM employee_territories;
SELECT * FROM employees;
SELECT * FROM territories;

SELECT last_name, territory_id, territory_description
FROM employees
LEFT JOIN employee_territories
USING(employee_id)
LEFT JOIN territories
USING(territory_id)

/* 7. **Products with Supplier Information**  
   Create a query to list all products along with their supplier's `company_name`, `contact_name`, and `country`.
   You can choose any number of columns to display from the products table.*/
SELECT * FROM products;
SELECT * FROM suppliers;

SELECT product_name, company_name, contact_name, country
FROM products
INNER JOIN suppliers
ON products.supplier_id = suppliers.supplier_id;

/* 8. **Orders and Shippers**  
   Write a query to display all orders, 
   including the `order_id`, `customer_id`, `order_date`, and the name of the shipper (`shippers.company_name`).*/

SELECT * FROM orders;
SELECT * FROM shippers;

SELECT order_id, customer_id, order_date, ship_via, company_name
FROM orders
LEFT JOIN shippers
ON orders.ship_via = shippers.shipper_id;

/* 9. **Customers Who Ordered Specific Products**  
   Find all customers who have ordered the product "Chai". Display the `customer_id`, `contact_name`, and `company_name`.*/

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM products;

/*SELECT customer_id, contact_name, company_name
" column reference "customer_id" is ambiguous" */
SELECT customers.customer_id, customers.contact_name, customers.company_name, products.product_name
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name = 'Chai';
