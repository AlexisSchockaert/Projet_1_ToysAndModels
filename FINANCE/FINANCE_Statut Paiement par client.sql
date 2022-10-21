-- VIEW------
-- Utilisation de la view payment_status
-- reprise dans le fichier FINANCE_Montant Factures impayées.sql


-- -----------------REQUETE POWER-BI-----------
-- Compte le nombre de clients par statut des paiements
SELECT payment_status, count(customerNumber) as nb_customers
FROM payment_analyze
GROUP BY payment_status;