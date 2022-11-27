-- ------------------REQUETE POWER-BI----------------------------------

-- récupère par mananer son nombre de managés et le nombre d'office où se situent les managés
SELECT CONCAT(m.lastName, ',',m.firstName) as fullName_manager,
COUNT(*) as number_employes, COUNT(DISTINCT(o.country)) as number_country
FROM employees AS m
INNER JOIN employees AS e ON m.employeeNumber = e.reportsTo
INNER JOIN offices AS o
ON e.officeCode = o.officeCode
GROUP BY fullName_manager
ORDER BY COUNT(country) DESC;