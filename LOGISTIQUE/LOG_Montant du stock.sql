-- --------------------REQUETE POWER-BI----------------
-- Calcule le montant du stock = qté * prix d'achat pour tous les produits
Select Sum(products.quantityinstock * buyprice) as Valeur_Stock_Global
FROM Products;