USE toys_and_models;


-- turnover for last 2 months by country (offices)
SELECT DATE_FORMAT(orders.orderDate,'%Y-%m') AS period_, offices.country AS pays, sum(quantityOrdered*priceEach) AS montant  
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
GROUP BY period_, pays 
ORDER BY period_; 



