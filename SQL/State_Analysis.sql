CREATE TABLE sales_dataset.State_Records AS
SELECT 
DISTINCT ssdv.State AS State ,
SUM(ssdv.Profit ) AS Profit
FROM sales_dataset.superstores_sales_data_v1 ssdv
GROUP BY State
ORDER BY Profit DESC 
