-- --------------VIEW--------------------------
-- Utilisation de la VIEW payment_analyze
-- reprise dans le fichier FINANCE_Montant Factures impayées.sql

-- Création d'une vue pour obtenir la liste des clients en attente de paiement
-- dont le dernier envoi date de + 60j
Create or replace view mauvais_payeur as 
SELECT customername, country, sum(pending_payment) as pendingamount,derniereenvoi
FROM payment_analyze
WHERE payment_status='Utilisation Crédit' OR 'Crédit dépassé'
GROUP BY  customername, country,derniereenvoi
HAVING derniereenvoi < NOW() - INTERVAL 2 MONTH
ORDER BY derniereenvoi ASC;