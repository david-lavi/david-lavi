
SELECT *
FROM[dbo].[OnlineSales]
SELECT*
FROM[dbo].[Promotion]
SELECT*
FROM[dbo].[Product]
SELECT*
FROM[dbo].[Calendar]

/*thist quarry shows how much sales there where when there was a promotion and with no promotion and counts the days after the start of the promotion and
the days before the promotion has ended as well the avrage date off the orders shown by date format */
SELECT DISTINCT MYTABLE.PromotionName,SUM(MYTABLE.SalesAmount) OVER(partition by MYTABLE.PromotionName ) AS SALES_AMOUNT_BY_PRO
,AVG(DATEDIFF(DAY,MYTABLE.STARTDATE,MYTABLE.OrderDate)) OVER(partition by MYTABLE.PromotionName ) AS DAYAFTERSTART
,CONVERT(DATETIME, AVG(CONVERT(FLOAT, MYTABLE.OrderDate))OVER(partition by MYTABLE.PromotionName)) as [AverageDate] 
,AVG(DATEDIFF(DAY,MYTABLE.OrderDate,MYTABLE.ENDDATE)) OVER(partition by MYTABLE.PromotionName ) AS DAYBEFFOREEND
FROM
(
/*this sub quarry shows the orders arranged by product name ,sales order number ,the promotion ,sales amount,and the order date and the start and end dates of the promotion, */
SELECT ProductName,SalesOrderNumber,PromotionName,SalesAmount,OrderDate,[dbo].[Promotion].StartDate AS STARTDATE,[dbo].[Promotion].EndDate AS ENDDATE
FROM[dbo].[OnlineSales]
JOIN [dbo].[Product] ON [dbo].[OnlineSales].ProductKey=[dbo].[Product].ProductKey
JOIN  [dbo].[Promotion] ON [dbo].[OnlineSales].PromotionKey=[dbo].[Promotion] .PromotionKey
) AS MYTABLE