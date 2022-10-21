-- ----------------REQUETE POWER-BI---------------

-- délai préparation en jour calendaire (Date Expédition - Date commande)
-- calcule la moyenne pour toutes les préparations de l'année en cours
SELECT AVG(DATEDIFF(shippedDate,orderDate))
FROM orders
WHERE YEAR(orderdate)=YEAR(NOW()) AND shippeddate IS NOT NULL;