-- ----------------REQUETE POWER-BI-----------alter
-- Récupère le CA par mois et par Paysclient pour l'année en cours
USE toys_and_models;
SELECT MONTH(orderdate) as month_,c.country,COUNT(DISTINCT(c.customerNumber)) as customrer_nbr,
SUM(od.priceEach*od.quantityOrdered) as ca
FROM customers as c
INNER JOIN orders as o
USING(customerNumber)
INNER JOIN orderdetails as od
USING(orderNumber)
WHERE (status like 'Shipped' or 'Resolved')
AND YEAR(o.orderdate) = YEAR(NOW())
GROUP BY month_,c.country
ORDER BY month_,CA desc;