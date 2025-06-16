CREATE TABLE Sales_Dataset.Monthly_Analysis AS
SELECT 
MONTH(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS No,
MONTHNAME(STR_TO_DATE(`Order Date`,'%c/%e/%Y')) AS Months ,
SUM(ssdv.Sales ) AS Sales,
SUM(ssdv.Profit ) AS Profit
FROM Sales_Dataset.superstores_sales_data_v1 ssdv
GROUP BY months, `no` 
ORDER BY NO

CREATE TABLE Sales_Dataset.Region_Analysis AS
SELECT 
ssdv.Region AS Region,
YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Year,
SUM(ssdv.Sales ) AS Sales,
SUM(ssdv.Profit ) AS Profit
FROM Sales_Dataset.superstores_sales_data_v1 ssdv 
GROUP BY region , `year` 
ORDER BY region , year
 
CREATE TABLE Sales_Dataset.Product_Category_Analysis AS
SELECT 
ssdv.Category AS Category,
YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Year,
SUM(ssdv.Sales ) AS Sales,
SUM(ssdv.Profit ) AS Profit
FROM Sales_Dataset.superstores_sales_data_v1 ssdv 
GROUP BY Category , Year 
ORDER BY Category , Year


CREATE TABLE Sales_Dataset.Top_Products AS
SELECT
ssdv.`Product Name` AS Product,
YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Year,
MAX(ssdv.Sales ) AS Sales,
MAX(ssdv.Profit ) AS Profit
FROM Sales_Dataset.superstores_sales_data_v1 ssdv 
GROUP BY Product , Year
ORDER BY  Year
