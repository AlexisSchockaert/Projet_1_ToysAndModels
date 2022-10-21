-- ----------------------SOUS REQUETE---------------------

-- récupère le CA par produit sur l'année glissante, sa valeur en stock et définit le rang du produit (par CA DESC)

WITH STOCK_VS_ORDERQTY as (
SELECT p.ProductCode, p.ProductName, p.Productline, 
sum(p.quantityinstock * buyprice) as Valeur_de_stock, 
sum(od.quantityOrdered) as sold_qty,
RANK() OVER(ORDER BY sum(od.quantityOrdered) DESC) as rang
From Products as p
LEFT JOIN orderdetails as od
USING(productCode)
INNER JOIN orders as o
USING(orderNumber)
WHERE orderDate>=NOW()-INTERVAL 1 YEAR
GROUP BY ProductCode, ProductName, Productline
ORDER BY sold_qty DESC)

-- --------------REQUETE-----------------
-- Récupère 5 premiers produits
SELECT ProductCode, ProductName,Productline,Valeur_de_stock,sold_qty,rang
FROM STOCK_VS_ORDERQTY
WHERE rang <=5;

