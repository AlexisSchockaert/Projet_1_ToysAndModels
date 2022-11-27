/*Affichage du nombre de commande ou la date Shippedate > a la date requiredate.
*/

USE toys_and_models;

SELECT YEAR(orderDate),count(orderNumber)
FROM orders
WHERE shippedDate > requiredDate
AND status !='Cancelled'
GROUP BY YEAR(orderDate);