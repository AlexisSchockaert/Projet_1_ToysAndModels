-- Utilisation de la base de données
USE Toys_and_models;

-- --------------------------------------------------------------------Couverture de stocks----------------------------------------------------------------------------------
-- On va afficher le code de production, le nom du produit, la quantité vendu sur 12 mois, nb vendu par mois, donc nb de semaines pour tt vendre.
-- Création d'une view Couverture

CREATE OR REPLACE VIEW  Couverture as (
WITH Couverture as (
SELECT Orderdetails.ProductCode, products.productname, sum(QuantityOrdered) as Nb_vendu, Quantityinstock
FROM orderdetails
INNER JOIN Orders on orders.ordernumber = orderdetails.ordernumber
INNER JOIN Products on products.productcode = orderdetails.productcode
WHERE Orderdate >= now() - interval 1 Year 
GROUP BY Products.productname
ORDER BY productname)

SELECT productcode as Code_Produit, 
productname as Nom_du_modèle, 
Nb_vendu, 
quantityinstock as Qté_en_stk, 
round(Nb_vendu/12,2) as Qté_vendu_par_Mois, 
round(Quantityinstock*12/Nb_vendu,1) as Couverture_Nb_Mois
FROM Couverture
ORDER BY Couverture_Nb_Mois ASC
);



-- TOP 5 FLUX TENDU
SELECT Code_Produit, 
Nom_du_modèle, 
Nb_vendu, 
Qté_en_stk, 
Qté_vendu_par_Mois, 
Couverture_Nb_Mois
FROM Couverture
ORDER BY Couverture_Nb_Mois ASC
LIMIT 5;


-- FLOP 5 STOCK DORMANT
SELECT Code_Produit, 
Nom_du_modèle, 
Nb_vendu, 
Qté_en_stk, 
Qté_vendu_par_Mois, 
Couverture_Nb_Mois
FROM Couverture
ORDER BY Couverture_Nb_Mois DESC
LIMIT 5;


-- Utilisation de la View Couverture, et on prends la liste des articles avec moins de 2 mois de couverture.
Select * FROM Couverture
WHERE Couverture_nb_mois < (
-- Utilisation d'une sous requete pour le calcul de la moyenne des couverture par mois
	SELECT round(avg(Couverture_nb_mois),2)
	FROM Couverture);

-- Utilisation de la View Couverture, et on prends la liste des articles avec + de 26 mois de couverture.
Select * 
FROM Couverture
WHERE Couverture_nb_mois > (
-- Utilisation d'une sous requete pour le calcul de la moyenne des couverture par mois
	SELECT round(avg(Couverture_nb_mois),2)
	FROM Couverture);

-- Utilisation de la View Couverture, et on afficher tt.
Select * FROM Couverture;


