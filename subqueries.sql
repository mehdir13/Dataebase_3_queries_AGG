-- This selects all the products with above average price.
-- The value within the parantheses (a subquery) will be a singular value and can therefore be used in a WHERE
SELECT product_name,
    unit_price
FROM products
WHERE unit_price > (
        SELECT AVG(unit_price)
        FROM products
    );
-- Using a WITH-statement to calculate total quantity per product
-- The WITH-statement will save the query result temporarily.
WITH ProductQuantity AS (
    SELECT p.product_name,
        SUM(od.quantity) AS total_quantity
    FROM products p
        JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.product_name
)
SELECT product_name,
    total_quantity
FROM ProductQuantity
WHERE total_quantity > 500;
-- Window function example: Rank orders by total revenue
-- Window functions uses the other rows to come up with a value for that row.
-- Contrast this to aggregate functions where other rows are used to come up with a singular value.
SELECT order_id,
    SUM(unit_price * quantity) AS order_total,
    RANK() OVER (
        ORDER BY SUM(unit_price * quantity) DESC
    ) AS revenue_rank
FROM order_details
GROUP BY order_id
ORDER BY revenue_rank;
-- PERCENT_RANK() to determine which percentile a unit_price pelongs to.
SELECT product_name,
    PERCENT_RANK() OVER (
        ORDER BY unit_price DESC
    )
FROM products;
-- Using partition by to group the rankinkgs per order
SELECT order_id,
    unit_price,
    quantity,
    unit_price * quantity AS order_value,
    RANK() OVER (
        PARTITION BY order_id
        ORDER BY unit_price * quantity DESC
    ) AS revenue_rank
FROM order_details
ORDER BY order_id;