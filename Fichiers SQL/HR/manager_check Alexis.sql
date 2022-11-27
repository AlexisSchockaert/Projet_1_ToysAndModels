-- Nombre de managé par manager

SELECT CONCAT(m.lastName, ',',m.firstName) as fullName_manager, COUNT(*) as number_employes, COUNT(DISTINCT(o.country)) as number_country
FROM employees AS m
INNER JOIN employees AS e 
ON m.employeeNumber = e.reportsTo
INNER JOIN offices AS o
ON e.officeCode = o.officeCode
GROUP BY fullName_manager
ORDER BY COUNT(country) DESC;

SELECT CONCAT(lastName, ',',firstName) as fullName
FROM employees
WHERE reportsTo is NULL;

SELECT DISTINCT(officeCode), country, city, postalCode
FROM offices
GROUP BY country, city, postalCode
ORDER BY officeCode asc