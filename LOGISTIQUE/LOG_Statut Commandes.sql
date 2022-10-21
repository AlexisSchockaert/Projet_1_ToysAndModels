-- ---------------REQUETE POWER-BI---------------------

-- compte le nb de commandes par statut pour l'année en cours

Select Orders.status, count(Orders.status) as Nb
FROM Orders
WHERE Year(orderDate) = Year(now())
GROUP BY Orders.status;