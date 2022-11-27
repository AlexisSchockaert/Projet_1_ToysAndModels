-- Nombre de clients / vendeurs


SELECT CONCAT(e.lastName, ', ',e.firstName) as lastname_firstname, COUNT(DISTINCT(c.customerNumber)) as total_customer_by_saler, sum(ord.quantityOrdered*ord.priceEach) as CA, MONTH(orderdate) as dateDuMois
FROM employees as e
INNER JOIN customers as c
ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN orders as o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails as ord
USING (orderNumber)
WHERE YEAR(o.orderDate) >= YEAR(NOW()) AND (o.status = "Shipped" OR "Resolved")
GROUP BY lastname_firstname, dateDuMois
ORDER BY total_customer_by_saler DESC;