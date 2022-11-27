-- --------------VIEW------------------------------

-- requête pour avoir par produit et par ligne de produit, le CA 
-- et le CA que l'entreprise aurait pu avoir si l'entreprise avait vendu le produit au prix MRSP
CREATE OR REPLACE view pave as (
SELECT Productcode, Productname,productline, sum(quantityordered) as Sum_qté_vendu, round(avg(priceeach),2) as Vendu_en_moyenne, MSRP, 
sum(quantityordered*MSRP) as Total_MSRP, sum(quantityordered*priceeach) as Total_Vendu
FROM orderdetails
INNER JOIN products
USING (productcode)
INNER JOIN orders
USING (ordernumber)
WHERE YEAR(orderDate) = YEAR(NOW())   
AND 'status' !='Cancelled' 
GROUP BY Productname);


-- ---------------REQUETE POWER-BI----------------
-- requête pour pouvoir utiliser les alias créés dans la View
SELECT *, Total_MSRP-Total_vendu  as Diff
From Pave
ORDER BY Diff ASC;