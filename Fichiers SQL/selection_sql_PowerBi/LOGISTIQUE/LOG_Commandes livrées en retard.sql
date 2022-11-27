-- -------------------REQUETE POWER-BI----------------------

-- Compte le nombre de commandes de l'année en cours où Date d'expédition est après la Date Besoin Client

SELECT YEAR(orderDate),count(orderNumber)
FROM orders
WHERE shippedDate > requiredDate
AND status !='Cancelled' AND YEAR(orderdate)=YEAR(NOW())
GROUP BY YEAR(orderDate);