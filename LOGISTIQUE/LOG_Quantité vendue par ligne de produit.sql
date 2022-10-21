-- -----------------------REQUETE POWER-BI--------------------

-- récupère par mois et par ligne de produit
-- la quantité vendue de l'année (SUM(CASE...))
-- la quantité vendue de l'année précédente (SUM(CASE...))
-- 
    SELECT MONTH(o.orderDate) as month_order,  
    p.productLine as productline, 
    sum(CASE  
        WHEN YEAR(o.orderDate)=year(now())-1 THEN od.quantityOrdered 
        ELSE 0 
        END) AS qty_lastyear, 
    sum(CASE  
        WHEN YEAR(o.orderDate)=year(now()) THEN od.quantityOrdered 
        ELSE 0 
        END) AS qty_year 
    FROM orderdetails as od 
    INNER JOIN orders as o 
    USING(orderNumber) 
    LEFT JOIN products as p 
    USING (productCode) 
    WHERE o.status !='Cancelled' 
    GROUP BY month_order,p.productLine 
    ORDER BY month_order,p.productLine ;
