CREATE TABLE Sales_Dataset.Monthly_Toppers AS
SELECT 
No,
Month  , 
Product,
Profit
FROM (
SELECT 
MONTH(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS No,
MONTHNAME(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Month,
`Product Name` AS Product ,
SUM(Profit) AS Profit ,
RANK() OVER( 
 PARTITION BY MONTHNAME(STR_TO_DATE(`Order Date`, '%c/%e/%Y'))
 ORDER BY SUM(Profit) DESC
 ) AS rnk 
FROM Sales_Dataset.superstores_sales_data_v1 ssdv 
GROUP BY No , Month , Product
) ranked_months
WHERE 
rnk = 1
ORDER BY No 


