-- Répartition des clients par Pays de résidence et CA par pays
USE toys_and_models;

SELECT c.country,
COUNT(DISTINCT(c.customerNumber)) as customrer_nbr, 
SUM(od.priceEach*od.quantityOrdered) as ca
FROM customers as c
INNER JOIN orders as o
USING(customerNumber)
INNER JOIN orderdetails as od
USING(orderNumber)
WHERE (status like 'Shipped' or 'Resolved')
AND YEAR(o.orderdate) = YEAR(NOW())
GROUP BY c.country
ORDER BY CA desc;



