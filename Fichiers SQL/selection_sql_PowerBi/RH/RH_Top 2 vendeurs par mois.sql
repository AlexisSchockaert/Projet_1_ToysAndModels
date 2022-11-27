-- ----------------------SOUS-REQUETE--------------------------------


-- calcule le CA par mois et par vendeur et définit un rang par CA descendant
WITH best_sellors AS(
SELECT  YEAR(orders.orderDate) as year_,MONTH(orders.orderDate) as Month_,
concat(employees.firstname,"" "",employees.lastname) as sellor, offices.country,
sum(orderdetails.priceEach*orderdetails.quantityOrdered) AS turnover,
RANK() OVER (PARTITION BY YEAR(orders.orderDate),MONTH(orders.orderDate) 
ORDER BY sum(orderdetails.priceEach*orderdetails.quantityOrdered) desc) as rank_best_sellor
FROM orderdetails
JOIN orders ON orders.orderNumber=orderdetails.orderNumber
JOIN customers ON customers.customerNumber = orders.customerNumber
JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices ON offices.officeCode = employees.officeCode
WHERE YEAR(orders.orderDate)>YEAR(NOW())-1
AND (orders.status ='Shipped' OR orders.status ='Resolved')
GROUP BY year_,Month_,employees.employeeNumber
ORDER BY year_,Month_ ASC ,rank_best_sellor ASC) 

-- --------REQUETE ------------------------------

-- récupère les vendeurs qui apparaissent en rang 1 et 2 par mois
SELECT year_,Month_, sellor, country, turnover,rank_best_sellor
FROM best_sellors 
WHERE rank_best_sellor<=2
GROUP BY year_,Month_,sellor
ORDER BY year_ desc ,Month_ desc,rank_best_sellor;