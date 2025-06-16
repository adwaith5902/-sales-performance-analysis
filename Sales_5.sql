CREATE TABLE sales_dataset.Summary
SELECT 
YEAR(STR_TO_DATE(`Order Date` , '%c/%e/%Y')) AS YEAR ,
ssdv.Country AS Country ,
COUNT(DISTINCT ssdv.`Customer ID`) AS Total_Customers ,
COUNT(DISTINCT ssdv.`Product ID` ) AS No_of_Products,
SUM(ssdv.Profit ) AS Profit,
SUM(ssdv.Sales ) AS Sales
FROM sales_dataset.superstores_sales_data_v1 ssdv 
GROUP BY YEAR,country

CREATE TABLE sales_dataset.Discount_Analysis AS
SELECT DISTINCT ssdv.Discount ,
SUM(ssdv.Profit ) AS Profit,
SUM(ssdv.Sales ) AS Sales
FROM sales_dataset.superstores_sales_data_v1 ssdv
GROUP BY discount 
ORDER BY sales DESC

CREATE TABLE sales_dataset.Top_5_products AS
SELECT 
YEAR,
Product,
Category,
Profit
FROM(  
SELECT 
YEAR(STR_TO_DATE(`Order Date` , '%c/%e/%Y')) AS YEAR ,
ssdv.`Product Name` AS Product ,
ssdv.`Category` AS Category,
SUM(ssdv.Profit) AS Profit,
RANK() OVER( 
PARTITION BY YEAR(STR_TO_DATE(`Order Date` , '%c/%e/%Y'))  
ORDER BY SUM(ssdv.Profit) DESC ) AS rnk
FROM sales_dataset.superstores_sales_data_v1 ssdv
GROUP BY YEAR,product,Category
) AS ranked
WHERE 
rnk <=5
ORDER BY YEAR

CREATE TABLE sales_dataset.Bottom_5_products AS
SELECT 
YEAR,
Product,
Category,
Profit
FROM(  
SELECT 
YEAR(STR_TO_DATE(`Order Date` , '%c/%e/%Y')) AS YEAR ,
ssdv.`Product Name` AS Product ,
ssdv.`Category` AS Category,
SUM(ssdv.Profit) AS Profit,
RANK() OVER( 
PARTITION BY YEAR(STR_TO_DATE(`Order Date` , '%c/%e/%Y'))  
ORDER BY SUM(ssdv.Profit) ASC ) AS rnk
FROM sales_dataset.superstores_sales_data_v1 ssdv
GROUP BY YEAR,product,Category
) AS ranked
WHERE 
rnk <=5
ORDER BY YEAR
