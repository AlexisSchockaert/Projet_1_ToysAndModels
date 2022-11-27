USE toys_and_models;


/*Comparaison entre le CA d'affaire généré des commandes de l'année
et le prix MSRP qui est le prix de vente conseillé par le fournisseur
L'objectif est de voir le potentiel CA supplémentaire si on vend en dessous du MSRP
*/

-- utilisation d'un WITH pour pouvoir utiliser les alias créés.

WITH Difference_between_priceEach_MSRP AS(
    SELECT DATE_FORMAT(o.orderDate,'%Y-%m') AS period_, p.productLine, 
    sum(od.quantityOrdered*od.priceEach) AS montant_vendus,
    sum(od.quantityOrdered*p.MSRP) as montant_MSRP
    FROM orderdetails as od
    INNER JOIN orders as o
    USING(orderNumber) 
    INNER JOIN products as p
    USING (productCode)
    WHERE YEAR(o.orderDate) = YEAR(NOW())   
    AND o.status !='Cancelled' 
    GROUP BY period_, p.productLine
    ORDER BY period_, p.productLine)

SELECT period_, productLine, montant_vendus,montant_MSRP,
montant_vendus-montant_MSRP  as diff_vente_MSRP
FROM Difference_between_priceEach_MSRP;

-- MSRP Via Jo
-- Création de la vue par article sur l'année en cours pour faire l'étude de la rentabilité via le MSRP
CREATE OR REPLACE view pave as (
SELECT Productcode, Productname,productline, sum(quantityordered) as Sum_qté_vendu, round(avg(priceeach),2) as Vendu_en_moyenne, MSRP, 
sum(quantityordered)*MSRP as Total_MSRP, sum(quantityordered)*round(avg(priceeach),2) as Total_Vendu
FROM orderdetails
INNER JOIN products
USING (productcode)
INNER JOIN orders
USING (ordernumber)
WHERE YEAR(orderDate) = YEAR(NOW())   
AND 'status' !='Cancelled' 
GROUP BY Productname);

SELECT *, Total_MSRP-Total_vendu as Diff
From Pave
ORDER BY Diff ASC;


