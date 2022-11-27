USE toys_and_models;

-- -------------SOUS REQUETE-------------------

-- MCD = CA - Prix Achat (charge directe)
-- requête permettant de récupérer par mois et par pays (office) le CA et le montant d'achat
-- pour l'année en cours et pour l'année précédente
-- les CASE permettent de traiter les cas : Année en cours / Année précédente
WITH Difference_between_priceEach_priceAmount AS(
    SELECT MONTH(orderDate) as month_, 
    offices.country as pays,
    SUM(CASE WHEN YEAR(orderDate)=YEAR(NOW()) THEN od.quantityOrdered*od.priceEach
    ELSE 0 END) AS montant_vendus,
    SUM(CASE WHEN YEAR(orderDate)=YEAR(NOW())-1 THEN od.quantityOrdered*od.priceEach
    ELSE 0 END) AS montant_vendus_lastyear,
    SUM(CASE WHEN YEAR(orderdate)=YEAR(NOW()) THEN od.quantityOrdered*p.buyPrice
    ELSE 0 END)  as montant_buyprice,
    SUM(CASE WHEN YEAR(orderdate)=YEAR(NOW())-1 THEN od.quantityOrdered*p.buyPrice
    ELSE 0 END)  as montant_buyprice_lastyear
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
    GROUP BY month_,pays
    ORDER BY month_,pays)


-- --------------------REQUETE POWER-BI -----------------------
-- requête qui permet de calculer le MCD en utilisant les alias créés dans la sous-requête
SELECT month_, pays,montant_vendus,montant_buyprice,
montant_vendus-montant_buyprice  as MCD,
montant_vendus_lastyear,montant_buyprice_lastyear,
montant_vendus_lastyear-montant_buyprice_lastyear  as MCD_lastyear
FROM Difference_between_priceEach_priceAmount;