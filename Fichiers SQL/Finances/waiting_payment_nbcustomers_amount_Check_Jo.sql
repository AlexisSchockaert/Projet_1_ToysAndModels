USE toys_and_models;

-- Création d'une vue pour générer une table avec le statut de paiement par client et le montant attendu
CREATE OR REPLACE VIEW payment_analyze AS
WITH comparaison_order_payment_by_customer AS(
SELECT c.customerNumber, C.customername, c.creditLimit ,
    (SELECT sum(amount)
    FROM payments
    WHERE customerNumber =c.customerNumber ) as payment,
    (SELECT sum(quantityOrdered*priceEach)
    FROM orderdetails
    INNER JOIN orders
    USING(orderNumber)
    WHERE customerNumber=c.customerNumber AND status!='Cancelled' ) as salesamount
FROM customers as c
GROUP BY c.customerNumber)

SELECT customerNumber, customername, creditLimit,payment,salesamount,
CASE 
    WHEN payment>=salesamount THEN 0
    ELSE salesamount-payment
END AS pending_payment,
CASE 
    WHEN salesamount is NULL THEN 'Pas Commande'
    WHEN payment>=salesamount THEN 'Payé'
    WHEN payment<salesamount+creditLimit THEN 'Utilisation Crédit'
    ELSE  'Crédit dépassé'
END AS payment_status
FROM comparaison_order_payment_by_customer ;

-- indicateur sur les statuts de paiement
SELECT payment_status, count(customerNumber) as nb_customers
FROM payment_analyze
GROUP BY payment_status;

-- indicateur sur le montant attendu
SELECT sum(pending_payment)
FROM payment_analyze;

select * from payment_analyze;