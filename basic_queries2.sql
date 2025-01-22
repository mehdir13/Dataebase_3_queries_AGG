-- 1. Retrieve all products with an alias for column names
SELECT product_id AS id, product_name AS name, unit_price AS price
FROM products;

-- 2. Find the top 5 most expensive products, ordered by price in descending order
SELECT product_id, product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 5;

-- 3. Find employees with a custom full_name column (using AS)
SELECT employee_id, first_name || ' ' || last_name AS full_name
FROM employees;

-- 4. Update the price of products from supplier with id 2
UPDATE products
SET unit_price = unit_price * 1.10
WHERE supplier_id = 2;

-- 5. Delete customers from a specific city (e.g., 'Berlin')
DELETE FROM customers
WHERE city = 'Berlin';

-- 6. Find suppliers in the USA and display their names in uppercase
SELECT supplier_id, UPPER(company_name) AS company_name_uppercase, country
FROM suppliers
WHERE country = 'USA';

-- 7. Retrieve orders, sorted first by customer_id (ascending) and then by order_date (descending)
SELECT order_id, customer_id, order_date
FROM orders
ORDER BY customer_id ASC, order_date DESC;


-- 8. Use a CASE statement to categorize products based on price
SELECT product_id, product_name, 
    CASE 
        WHEN unit_price < 10 THEN 'Cheap'
        WHEN unit_price BETWEEN 10 AND 50 THEN 'Moderate'
        ELSE 'Expensive'
    END AS price_category
FROM products;
