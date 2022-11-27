
USE toys_and_models;

SELECT orderNumber,count(productCode)
FROM orderdetails
GROUP BY orderNumber;


SELECT od1.orderNumber, 
od1.productCode as produit1,
od2.productCode as produit2
    FROM orderdetails as od1
    INNER JOIN orderdetails as od2
    USING(orderNumber)
    WHERE od1.productCode!=od2.productCode
    GROUP BY od1.ordernumber, od1.productCode;
-- sous requête permet d'afficher sur un même tuple les produits d'une même
-- commande 2 par 2
WITH sameorder as(
    SELECT od1.orderNumber, od1.productCode as produit1,od2.productCode as produit2
    FROM orderdetails as od1
    INNER JOIN orderdetails as od2
    USING(orderNumber)
    WHERE od1.productCode!=od2.productCode
    GROUP BY od1.ordernumber, od1.productCode)


-- compte le nombre de commandes où 2 produits sont ensemble
SELECT produit1,produit2,count(ordernumber)
FROM sameorder
GROUP by produit1,produit2;


-- idem avant avec un RANK pour avoir le produit le plus commandé
CREATE OR REPLACE VIEW CommanderEnsemble AS
WITH sameorder as(
    SELECT od1.orderNumber, od1.productCode as produit1,od2.productCode as produit2
    FROM orderdetails as od1
    INNER JOIN orderdetails as od2
    USING(orderNumber)
    WHERE od1.productCode!=od2.productCode
    GROUP BY od1.ordernumber, od1.productCode)


-- compte le nombre de commandes où 2 produits sont ensemble
SELECT produit1,produit2,count(ordernumber) as NbcommandeEns,
RANK() OVER (PARTITION BY produit1 ORDER BY count(ordernumber) DESC) as rang
FROM sameorder
GROUP by produit1,produit2;


-- requête pour ne garder que le produit le plus commandé
SELECT produit1,produit2 as lepluscommandeavec, NbcommandeEns
FROM commanderensemble
WHERE rang = 1;



CREATE OR REPLACE VIEW CommanderEnsemble2 AS
WITH sameorder as(
    SELECT od1.orderNumber, od1.productCode as produit1,od2.productCode as produit2
    FROM orderdetails as od1
    INNER JOIN orderdetails as od2
    USING(orderNumber)
    WHERE od1.productCode!=od2.productCode
    GROUP BY od1.ordernumber, od1.productCode)


-- compte le nombre de commandes où 2 produits sont ensemble
SELECT produit1,
(SELECT count(productCode)
FROM orderdetails
WHERE productCode=produit1 ) as NbOrder_produit1,
produit2,count(ordernumber) as NbcommandeEns,
RANK() OVER (PARTITION BY produit1 ORDER BY count(ordernumber) DESC) as rang
FROM sameorder
GROUP by produit1,produit2;


-- récupère pour chaque produit, le nb de commmandes,
-- le produit le plus commande, avec le nombre de commandes ensemble
-- le % de commandes passées ensemble
SELECT produit1,Nborder_produit1,produit2,nbcommandeens,rang,
ROUND(nbcommandeens/Nborder_produit1*100,2) as ratio
FROM CommanderEnsemble2
WHERE rang =1;



-- requêtes de contrôle
SELECT count(ordernumber)
FROM orderdetails
WHERE productCode='S10_1678';

SELECT *
FROM commanderensemble
WHERE produit1='S10_2016';