-- -------------REQUETE POWER-BI--------------

-- récupère les 5 produits les plus vendus depuis le début de l'année
SELECT productcode, productname, sum(quantityOrdered) as Qté_vendu
From orderdetails
join orders
Using (ordernumber)
join products
using (productcode)
where year(orderdate) = year(now())
Group By quantityordered
order by Qté_vendu DESC
limit 5;


-- ---------------REQUETE POWER-BI----------
-- récupère les 5 produits les moins vendus depuis le début de l'année
select productcode, productname, sum(quantityOrdered) as Qté_vendu
From orderdetails
join orders
Using (ordernumber)
join products
using (productcode)
where year(orderdate) = year(now())
Group By quantityordered
order by Qté_vendu ASC
limit 5;