SELECT 
SUM(ssdv.Sales ) ,
SUM(ssdv.Profit )
FROM Sales_Dataset.superstores_sales_data_v1 ssdv

CREATE TABLE Sales_Dataset.summary AS
SELECT 
SUM(ssdv.Sales) AS Total_Sales ,
SUM(ssdv.Profit) AS Total_Profit
FROM Sales_Dataset.superstores_sales_data_v1 ssdv;

SELECT 
  YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Order_Year ,
  SUM(Sales)
FROM Sales_Dataset.superstores_sales_data_v1
GROUP BY Order_Year ;

CREATE TABLE Sales_Dataset.Yearly_Analysis ( 
Order_Year VARCHAR(50),
Sales DECIMAL(10,2) ) ;

INSERT INTO Sales_Dataset.Yearly_Analysis (Order_Year, Sales)
SELECT 
  YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Order_Year,
  SUM(Sales) AS Sales
FROM Sales_Dataset.superstores_sales_data_v1
GROUP BY Order_Year
ORDER BY Order_Year;

SELECT 
  YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Order_Year,
  SUM(Profit ) AS profit
FROM Sales_Dataset.superstores_sales_data_v1
GROUP BY Order_Year

ALTER TABLE Sales_Dataset.Yearly_Analysis
ADD COLUMN Profit DECIMAL(10, 2);

UPDATE Sales_Dataset.Yearly_Analysis AS ya
JOIN (
  SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Order_Year,
    SUM(Profit) AS Total_Profit
  FROM Sales_Dataset.superstores_sales_data_v1
  GROUP BY Order_Year
) AS src
ON ya.Order_Year = src.Order_Year
SET ya.Profit = src.Total_Profit;
