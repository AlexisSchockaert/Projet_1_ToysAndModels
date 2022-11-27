USE toys_and_models;

-- for each productline and month, sum ordered qty for the year, for last year, and calculate the ratio A/A-1
WITH nb_order AS( 
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
    ORDER BY month_order,p.productLine) 

 
SELECT month_order,productline , qty_lastyear,qty_year, qty_year/qty_lastyear-1 as rate 
    FROM nb_order; 