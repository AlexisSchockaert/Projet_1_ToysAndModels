-- -----------------VIEW--------------------
-- View utilisée aussi dans les requêtes :
-- - FINANCE_Paiement en attente 60 jours
-- - FINANCE_Statut paiement par client

-- -------------SOUS REQUETE---------------------
-- sous-requête pour récupérer le montant des commandes et le montant des factures payées par client
-- récupère aussi la dernière date d'expédition vers le client
-- la sous-requête permet de récupérer le montant des paiements du client (requête récursive)
CREATE OR REPLACE VIEW payment_analyze AS
WITH comparaison_order_payment_by_customer AS(
SELECT c.customerNumber, C.customername, c.country, c.creditLimit ,sum(quantityOrdered*priceEach) as salesamount,
    (SELECT sum(amount)
    FROM payments
    WHERE customerNumber =c.customerNumber ) as payment,
MAX(shippedDate) as derniereenvoi
FROM customers as c
INNER JOIN orders
USING(customerNumber)
INNER JOIN orderdetails
USING(orderNumber)
WHERE status!='Cancelled'
GROUP BY c.customerNumber, C.customername, c.country,c.creditLimit)

-- -----------------------REQUETE VIEW-------------
-- récupère les informations de la sous-requête, puis détermine le reste à payer par client.
-- définit un statut par client pour le paiement des factures
SELECT customerNumber, customername, country, creditLimit,payment,salesamount,
CASE 
    WHEN payment>=salesamount THEN 0
    ELSE salesamount-payment
END AS pending_payment,
CASE 
    WHEN salesamount is NULL THEN 'Pas Commande'
    WHEN payment>=salesamount THEN 'Payé'
    WHEN payment<salesamount+creditLimit THEN 'Utilisation Crédit'
    ELSE  'Crédit dépassé'
END AS payment_status,
derniereenvoi
FROM comparaison_order_payment_by_customer ;


-- ---------------REQUETE POWER-BI ---------------------
-- Compte le montant total des factures impayées par la société
SELECT sum(pending_payment)
FROM payment_analyze;


