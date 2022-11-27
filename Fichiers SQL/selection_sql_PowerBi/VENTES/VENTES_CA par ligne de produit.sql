-- ------------REQUETE POWER-BI---------------------

-- récupère le CA par mois et par ligne de produit

SELECT MONTH(orderdate) AS month_, p.productLine,
sum(od.quantityOrdered*od.priceEach) AS montant_vendus
FROM orderdetails as od
INNER JOIN orders as o
USING(orderNumber)
INNER JOIN products as p
USING (productCode)
WHERE YEAR(o.orderDate) = YEAR(NOW())
AND (o.status ='Shipped' OR 'Resolved')
GROUP BY month_,  p.productLine
ORDER BY month_,  p.productLine;