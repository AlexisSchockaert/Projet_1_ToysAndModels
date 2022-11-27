SELECT DISTINCT(status) FROM orders;

-- Evolution du statut de la commande chaque mois

SELECT comments FROM orders WHERE status LIKE 'on hold';

SELECT status, MONTH(orderDate), COUNT(*)
FROM orders
WHERE orderDate > LAST_DAY(now() - INTERVAL 3 MONTH)
GROUP BY status, MONTH(orderDate)
ORDER BY MONTH(orderDate) DESC;