-- Utilisation de la base de données
USE Toys_and_models;

-- Cela concerne les stocks

-- Valeurs de stocks
SELECT ProductCode, ProductName, Productline, sum(Products.quantityinstock * buyprice) as Valeur_de_stock
From Products
GROUP BY ProductCode, ProductName, Productline;

-- Valeur de stock Global
Select Sum(products.quantityinstock * buyprice) as Valeur_Stock_Global
FROM Products;

-- Valeur de stock par Famille de produits
SELECT Productline, SUM(Products.quantityinstock * buyprice) as Valeur_de_stock
FROM Products
GROUP BY Productline;