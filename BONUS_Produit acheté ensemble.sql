-- ---------------VIEW-------------------------

-- ------------SOUS-REQUETE--------------------
-- récupère par produit d'une commande, les autres articles achetés sur cette même commande
-- jointure avec la table Products pour récupérer le nom des produits
CREATE OR REPLACE VIEW CommanderEnsemble2 AS
WITH sameorder as(
    SELECT od1.orderNumber, od1.productCode as produit1,p1.productname as Produit1Name,od2.productCode as produit2,p2.productname as Produit2Name
    FROM orderdetails as od1
    INNER JOIN orderdetails as od2
    USING(orderNumber)
    INNER JOIN products as p1
    ON od1.productCode = p1.productCode
    INNER JOIN products as p2
    ON od2.productCode = p2.productCode
    WHERE od1.productCode!=od2.productCode
    GROUP BY od1.ordernumber, od1.productCode)

-- REQUETE VIEW
-- compte le nombre de couples Produit1-Produit2 qui apparaissent ensemble dans les commandes
-- définit un rang par couple Produit1-Produit2 pour connaître les articles qui sont les plus souvent achetés ensemble
SELECT produit1, produit1name,
(SELECT count(productCode)
FROM orderdetails
WHERE productCode=produit1 ) as NbOrder_produit1,
produit2, produit2name, count(ordernumber) as NbcommandeEns,
RANK() OVER (PARTITION BY produit1 ORDER BY count(ordernumber) DESC) as rang
FROM sameorder
GROUP by produit1,produit2;



-- -------------------------REQUETE POWER-BI-------------
-- Récupère les informations de la sous-requête et ne garde que les couples Produit1-Produit2 de rang 1

SELECT produit1, Produit1Name,Nborder_produit1,produit2, Produit2Name,nbcommandeens,rang,
ROUND(nbcommandeens/Nborder_produit1*100,2) as ratio
FROM CommanderEnsemble2
WHERE rang =1;