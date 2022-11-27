USE Toys_and_models;

-- Cela concerne les stocks

-- Valeurs de stocks
SELECT ProductCode, ProductName, Productline, Products.quantityinstock * buyprice as Valeur_de_stock
From Products;

-- Valeur de stock Global
Select Sum(products.quantityinstock * buyprice) as Valeur_Stock_Global
FROM Products;

-- Valeur de stock par Famille de produits
SELECT Productline, sum(Products.quantityinstock * buyprice) as Valeur_de_stock
FROM Products
GROUP BY Productline;


USE Toys_and_models;

-- Afficher les status des commandes groupées
Select Orders.status, count(Orders.status) as Nb
FROM Orders
WHERE Year(orderDate) = Year(now())
GROUP BY Orders.status;

-- Afficher les status des commandes groupées a Mois - 2
Select YEAR(orderDate),month(orderDate),Orders.status, count(Orders.status) as Nb
FROM Orders
WHERE orderDate> last_day(now() - INTERVAL 3 MONTH) AND orderDate<= last_day(now() - INTERVAL 1 MONTH)
GROUP BY Orders.status,YEAR(orderDate),month(orderDate);

-- Afficher les commandes d'un article voir le WHERE
SELECT products.productcode, productname, sum(quantityordered) as qty
FROM orderdetails
INNER JOIN products on products.productcode = orderdetails.productcode
INNER JOIN orders USING(ordernumber)
WHERE YEAR(orderDate)=year(NOW()) AND status!='Cancelled'
GROUP BY products.productcode ;

-- Total des payements des clients. 
select customers.customername, customers.customernumber, sum(amount) as TT_payements
FROM payments
INNER JOIN customers on customers.customernumber = payments.customernumber
Group by customernumber;

-- Montant de tte les cdes, par commandes
SELECT customernumber, orders.ordernumber, orderdetails.quantityordered * orderdetails.priceeach as Montant_cde
From Orderdetails
INNER JOIN orders on orders.ordernumber = orderdetails.ordernumber
group by ordernumber