-- --------------------REQUETE POWER-BI----------------

-- CA sur les 2 derniers mois pleins par paysOffice
SELECT DATE_FORMAT(orders.orderDate,'%Y-%m') AS period_, offices.country AS pays, 
sum(quantityOrdered*priceEach) AS montant
FROM orderdetails
JOIN orders
USING(orderNumber)
JOIN customers
USING(customerNumber)
JOIN employees
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices
USING(officeCode)
WHERE orders.orderDate > LAST_DAY(NOW() - INTERVAL 3 MONTH) and orders.orderDate <= LAST_DAY(NOW() - INTERVAL 1 MONTH)
AND (orders.status ='Shipped' OR orders.status ='Resolved' )
GROUP BY period_, pays#, montant(lf)ORDER BY period_;