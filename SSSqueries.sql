
--Find out Totals for every order and create table
SELECT Order_ID, SUM(Total_Price) AS Order_Total
INTO order_tot
FROM SSS_OrderLog
GROUP BY Order_ID

--Add Order Total column to Order Log 
ALTER TABLE SSS_OrderLog
ADD Order_Total money

--Set Order Total column in Order Log to corresponding values in order_tot 
UPDATE SSS_OrderLog
SET SSS_OrderLog.Order_Total = order_tot.Order_Total
FROM SSS_OrderLog
JOIN order_tot ON SSS_OrderLog.Order_ID = order_tot.Order_ID

--Find out which customers bought more than one distinct items
SELECT Customer_Name
FROM SSS_OrderLog
GROUP BY Customer_Name
HAVING COUNT(Item_ID)>1

--Sort days by number of orders
SELECT DATENAME(WEEKDAY,Order_Date) weekday, COUNT(DISTINCT Order_ID) NumOrders
FROM SSS_OrderLog
GROUP BY Order_Date
ORDER BY COUNT(DISTINCT Order_ID) DESC

--Sort days by total number of items sold
SELECT DATENAME(WEEKDAY,Order_Date) weekday , SUM(Quantity) TotUnitsSold
FROM SSS_OrderLog
GROUP BY Order_Date
ORDER BY SUM(Quantity) DESC

--Sort days by Revenue 
SELECT DATENAME(WEEKDAY,Order_Date) weekday, SUM(Total_Price) AS Revenue
FROM SSS_OrderLog
GROUP BY Order_Date
ORDER BY Revenue DESC

--Name the bestselling item on January 6th and how many units sold
SELECT TOP 1 Item_Name, SUM(Quantity) Units_Sold
FROM SSS_OrderLog
    JOIN SSS_StockControl
    ON SSS_StockControl.Item_ID = SSS_OrderLog.Item_ID
WHERE Order_Date = '2024-01-06' 
GROUP BY Item_Name
ORDER BY Units_Sold DESC

--Find out which items need to be restocked before the order can be processed and the order ID's containing these items(Quantity In Stock - Units Sold is negative)
SELECT Item_Name, Order_ID, Stock_after_processed FROM (SELECT Item_Name, Order_ID, Quantity, Quantity_In_Stock-SUM(Quantity) OVER (Partition by Item_Name ORDER BY Order_ID) Stock_after_processed
FROM SSS_OrderLog
    JOIN SSS_StockControl
    ON SSS_StockControl.Item_ID = SSS_OrderLog.Item_ID
GROUP BY Item_Name, Quantity_In_Stock, Order_ID, Quantity) TEMPORARY
WHERE Stock_after_processed < 0 
Order BY Order_ID


--Find out average units per order for every weekday
SELECT DATENAME(WEEKDAY,Order_Date) weekday , CAST(SUM(Quantity)AS DEC(4,2))/COUNT(DISTINCT Order_ID)  UnitsPerOrder
FROM SSS_OrderLog
GROUP BY Order_Date
ORDER BY UnitsPerOrder DESC

--Name the bestselling item for every weekday and how many units sold 
SELECT DATENAME(WEEKDAY,Order_Date) weekday, Item_Name, SUM(Quantity) Units_Sold INTO temp
FROM SSS_OrderLog
    JOIN SSS_StockControl
    ON SSS_StockControl.Item_ID = SSS_OrderLog.Item_ID
GROUP BY Order_Date, Item_Name;


SELECT weekday, Item_Name, Units_Sold
FROM   temp t1
WHERE  Units_Sold=(SELECT MAX(t2.Units_Sold)
              FROM temp t2
              WHERE t1.weekday = t2.weekday)
ORDER BY weekday

