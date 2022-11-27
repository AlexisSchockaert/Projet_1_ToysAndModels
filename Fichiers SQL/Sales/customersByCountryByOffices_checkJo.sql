USE toys_and_models;

-- Répartition des clients par pays des Offices

SELECT o.country, COUNT(c.customerName) as total_customer
FROM employees as e
INNER JOIN offices as o
USING (officeCode)
INNER JOIN customers as c
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY o.country

ORDER BY COUNT(c.customerName) DESC;