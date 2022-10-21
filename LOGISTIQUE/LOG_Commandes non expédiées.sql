-- -------------------REQUETE POWER-BI------------------------

-- Compte le nombre de commandes non expédiées à +2 jours
SELECT YEAR(orderdate), MONTH(orderdate), status, count(orderNumber)
FROM orders
WHERE orderdate < (NOW() - INTERVAL - 2 DAY) AND shippeddate IS  NULL AND status !='CANCELLED'
GROUP BY YEAR(orderdate),MONTH(orderdate), status
ORDER BY MONTH(orderdate) desc;