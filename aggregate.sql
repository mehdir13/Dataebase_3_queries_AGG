-- Summerar hur många produkter som har beställts totalt
SELECT SUM(quantity)
FROM order_details;
-- Returnerar största värdet från products.unit_price, MIN() tar det minsta värdet
SELECT MAX(unit_price)
FROM products;
SELECT MIN(unit_price)
FROM products;
-- GROUP BY delar upp SUM() i per order.
-- Vi får nu SUM(quantity) per order.
SELECT order_id,
    SUM(quantity)
FROM order_details
GROUP BY order_id;
-- Du kan filtrera bort rader innan du summerar dem med WHERE
SELECT order_id,
    SUM(unit_price)
FROM order_details
WHERE unit_price > 250
GROUP BY order_id;
-- Om du vill filtrera resultatet efter du summerat använder du HAVING
SELECT order_id,
    SUM(unit_price * quantity)
FROM order_details
GROUP BY order_id
HAVING SUM(unit_price * quantity) > 100;
/*
 1. SUM() med GROUP BY
 2. COUNT()
 3. MAX(), MIN(), AVG()
 4. HAVING
 5. HAVING vs WHERE
 */