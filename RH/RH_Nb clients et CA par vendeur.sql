-- -----------REQUETE POWER-BI--------------------------------

-- récupère par Vendeur, son nombre de clients et son CA sur l'année
SELECT CONCAT(e.lastName, ', ',e.firstName) as lastname_firstname, 
COUNT(DISTINCT(c.customerNumber)) as total_customer_by_saler, 
sum(ord.quantityOrdered*ord.priceEach) as CA
FROM employees as e
INNER JOIN customers as c ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails as ord
USING (orderNumber)
WHERE YEAR(o.orderDate) >= YEAR(NOW()) AND (o.status = "Shipped" OR "Resolved")
GROUP BY lastname_firstname
ORDER BY total_customer_by_saler DESC;