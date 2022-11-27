-- --------------------VIEW--------------------------------

-- -----------SOUS-REQUETE----------------------
-- Récupère par produit
-- la quantité vendue sur 1 an glissant
-- la quantité en stock
CREATE OR REPLACE VIEW  Couverture as (
WITH Couverture as (
SELECT Orderdetails.ProductCode, products.productname, sum(QuantityOrdered) as Nb_vendu, Quantityinstock
FROM orderdetails
INNER JOIN Orders on orders.ordernumber = orderdetails.ordernumber
INNER JOIN Products on products.productcode = orderdetails.productcode
WHERE Orderdate >= now() - interval 1 Year 
GROUP BY Products.productname
ORDER BY productname)

-- ------------REQUETE-----------------
-- calcule la quantité moyenne vendue par mois par produit = Qté vendus / 12
-- calcule le taux de couverture = Stock / Quantité moyenne par mois
SELECT productcode as Code_Produit, 
productname as Nom_du_modèle, 
Nb_vendu, 
quantityinstock as Qté_en_stk, 
round(Nb_vendu/12,2) as Qté_vendu_par_Mois, 
round(Quantityinstock*12/Nb_vendu,1) as Couverture_Nb_Mois
FROM Couverture
ORDER BY Couverture_Nb_Mois ASC
);

-- ----------------REQUETE POWER-BI----------------

-- Tri par taux de couverture ASC  (flux tendu)
-- récupère les 5 premiers produits

SELECT Code_Produit, 
Nom_du_modèle, 
Nb_vendu, 
Qté_en_stk, 
Qté_vendu_par_Mois, 
Couverture_Nb_Mois
FROM Couverture
ORDER BY Couverture_Nb_Mois ASC
LIMIT 5;

-- ----------------REQUETE POWER-BI----------------

-- Tri par taux de couverture DESC  (stock dormant)
-- récupère les 5 premiers produits

SELECT Code_Produit, 
Nom_du_modèle, 
Nb_vendu, 
Qté_en_stk, 
Qté_vendu_par_Mois, 
Couverture_Nb_Mois
FROM Couverture
ORDER BY Couverture_Nb_Mois DESC
LIMIT 5;