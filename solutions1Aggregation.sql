/* Aggregation Exercises

1. **Total Sales Per Product**  
   Find the total sales for each product by calculating the sum of `(unit_price * quantity)` in the `order_details` table.
   Display the `product_id` and `total_sales`.*/
SELECT * from order_details;

SELECT product_id,
    SUM(unit_price * quantity) AS total_sales
FROM order_details
GROUP BY product_id;

/* 2. **Average Order Value**  
   Calculate the average value of all orders.
   Use the `order_details` table and consider the formula `(unit_price * quantity * (1 - discount))` for each order detail.*/

SELECT product_id,
    AVG(unit_price * quantity * (1 - discount)) AS average_order_value
FROM order_details
GROUP BY product_id;

/*or we could use a subquery: first to compute the average value of each row in a order_value and then use subqeury to calcualte the average_order_value*/

/* 3. **Category-wise Product Count**  
   Display the number of products in each category. The columns should be `category_id` and `amount`.*/
SELECT * FROM products;

SELECT category_id,
    COUNT(product_id) AS amount
FROM products
GROUP BY category_id
ORDER BY category_id;

/*4. **Monthly Sales in 1997**  
   Calculate the total number of orders for each month in 1997. Hint: Look up DATE_TRUNC()*/
SELECT * FROM orders;

SELECT DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS total_orders
FROM orders
WHERE DATE_TRUNC('year', order_date) = '1997-01-01'
GROUP BY month
ORDER BY month;
