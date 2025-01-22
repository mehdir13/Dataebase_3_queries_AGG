/* 1. https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/

/* 1 */
SELECT v.customer_id,
    COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t on v.visit_id = t.visit_id
WHERE transaction_id is NULL
GROUP BY customer_id
ORDER BY customer_id

/* 2 */
SELECT customer_id,
    COUNT(visit_id) AS count_no_trans 
FROM Visits
WHERE visit_id NOT IN (
	SELECT visit_id FROM Transactions
	)
GROUP BY customer_id

/* 3 */
SELECT customer_id,
    COUNT(visit_id) AS count_no_trans 
FROM Visits v
WHERE NOT EXISTS (
	SELECT visit_id FROM Transactions t 
	WHERE t.visit_id = v.visit_id
	)
GROUP BY customer_id

/* 2. https://leetcode.com/problems/big-countries/ */
SELECT name, population, area
FROM World
WHERE population > 25000000 OR area > 3000000

/* 3. https://leetcode.com/problems/duplicate-emails/description/ */
/* 1 */
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;

/* 2 */
SELECT DISTINCT(p1.email)
FROM Person p1, Person p2
WHERE p1.id <> p2.id AND p1.email = p2.email;

/* 3 */ 
SELECT DISTINCT(p1.email)
FROM Person p1
JOIN Person p2
ON p1.email = p2.email AND p1.id <> p2.id;

/* 4. https://leetcode.com/problems/employees-earning-more-than-their-managers/description/ */
SELECT e2.name AS "Employee"
FROM employee e1
JOIN employee e2
ON e1.id = e2.managerId
WHERE e1.id = e2.managerId AND e1.salary < e2.salary

/* 5. https://leetcode.com/problems/classes-more-than-5-students/ */
SELECT class
FROM Courses
GROUP BY class 
HAVING COUNT(class) >= 5

/* 6. https://leetcode.com/problems/patients-with-a-condition/description/ */
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions LIKE '%DIAB1%'

/* ### Medium
1. https://leetcode.com/problems/capital-gainloss/description/ */
SELECT stock_name,
SUM(
    CASE
        WHEN operation = 'Buy' THEN -price
        ELSE price
    END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name

/* 2. https://leetcode.com/problems/odd-and-even-transactions/description/ */
SELECT transaction_date,
    SUM(
        CASE
            WHEN amount%2 != 0 THEN amount
            ELSE 0
        END
    ) AS odd_sum,
    SUM(
        CASE
            WHEN amount%2 = 0 THEN amount
            ELSE 0
        END
    ) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date


/* 2 */
SELECT transaction_date,
    coalesce(sum(amount) FILTER (WHERE amount & 2 = 1), 0) AS odd_sum,
    coalesce(sum(amount) FILTER (WHERE amount & 2 = 0), 0) AS even_sum
  FROM transactions
 GROUP BY transaction_date
 ORDER BY transaction_date;