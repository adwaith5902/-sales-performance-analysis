CREATE TABLE Sales_Dataset.Top_Products AS
SELECT 
  Year,
  Product,
  Total_Profit
FROM (
  SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y')) AS Year,
    `Product Name` AS Product,
    SUM(Profit) AS Total_Profit,
    RANK() OVER (
      PARTITION BY YEAR(STR_TO_DATE(`Order Date`, '%c/%e/%Y'))
      ORDER BY SUM(Profit) DESC
    ) AS rnk
  FROM Sales_Dataset.superstores_sales_data_v1 ssdv 
  GROUP BY Year, Product
) AS ranked_products
WHERE rnk = 1
ORDER BY Year;
