
USE toys_and_models;

-- nb Commandes en retard livraison
SELECT YEAR(orderDate),count(orderNumber)
FROM orders
WHERE shippedDate > requiredDate
AND status !='Cancelled'
GROUP BY YEAR(orderDate);

