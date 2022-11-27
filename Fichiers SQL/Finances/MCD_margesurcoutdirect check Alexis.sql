USE toys_and_models;


/*Comparaison entre le CA d'affaire généré des commandes de l'année
et le prix d'achat des produits
L'objectif est d'obtenir la marge sur coût direct
*/

-- utilisation d'un WITH pour pouvoir utiliser les alias créés.

WITH Difference_between_priceEach_priceAmount AS(
    SELECT CONCAT(YEAR(orderDate),'-',MONTH(orderDate),'-',1) as period_, offices.country as pays,
    sum(od.quantityOrdered*od.priceEach) AS montant_vendus,
    sum(od.quantityOrdered*p.buyPrice) as montant_buyprice
    FROM orderdetails as od
    INNER JOIN orders as o
    USING(orderNumber) 
    INNER JOIN products as p
    USING (productCode)
    INNER JOIN customers as c
    USING(customerNumber)
    INNER JOIN employees as e
    ON c.salesRepEmployeeNumber = e.employeeNumber
    INNER JOIN offices 
    USING(officeCode)
    WHERE YEAR(o.orderDate) >= YEAR(NOW())-1   
    AND o.status !='Cancelled' 
    GROUP BY period_,pays
    ORDER BY period_,pays)

SELECT period_, pays,montant_vendus,montant_buyprice,
montant_vendus-montant_buyprice  as MCD
FROM Difference_between_priceEach_priceAmount;