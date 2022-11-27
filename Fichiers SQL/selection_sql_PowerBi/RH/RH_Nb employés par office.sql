-- ----------------------REQUETE POWER-BI-----------------------------------------

-- compte le nombre d'employés par PaysOffice
SELECT country, COUNT(*) as nombre_employes
FROM employees as e
LEFT JOIN offices as o
USING (officeCode)
GROUP BY o.country
ORDER BY nombre_employes desc;