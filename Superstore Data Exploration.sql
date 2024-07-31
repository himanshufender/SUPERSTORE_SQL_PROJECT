
--(BASIC)
--1.List the top 10 orders with the highest sales from the EachOrderBreakdown table .
  
  SELECT TOP 10 * 
  FROM EachOrderBreakdown 
  ORDER BY Sales DESC 
  
--2.Show the number of orders for each product category in the EachOrderBreakdown table.

  SELECT Category,COUNT(*) as numoforders
  from EachOrderBreakdown 
  GROUP BY Category ; 

--3.Find the total profit for each sub-category in the EachOrderBreakdown table.

SELECT SubCategory,SUM(Profit) as TotalPROFIT
  from EachOrderBreakdown 
  GROUP BY SubCategory ; 

--(INTERMEDIATE)
--1.Identify the customer with the highest total sales across all orders.

SELECT * FROM  OrdersList
SELECT * FROM EachOrderBreakdown 

SELECT top 1 CustomerName,sum(Sales) as TotalSales
from OrdersList ol
join EachOrderBreakdown ob
on ol.OrderID = ob.OrderID 
group by CustomerName 
order by TotalSales desc ;

--2.Find the month with the highest average sales in the OrdersList table.

SELECT * FROM  OrdersList
SELECT * FROM EachOrderBreakdown 

select TOP 1 month(OrderDate)AS MONTH, AVG(Sales) AS AVG_SALES
from OrdersList ol
join EachOrderBreakdown ob
on ol.OrderID = ob.OrderID 
GROUP BY MONTH(OrderDate)
ORDER BY AVG_SALES DESC 

--3.Find out the average quantity ordered by customers whose first name starts with an alphabet 's'?

SELECT AVG(Quantity)as AverageQuantity 
FROM OrdersList ol
join EachOrderBreakdown ob on ol.OrderID = ob.orderid
where LEFT(CustomerName,1) = 'S'

--(Advanced)
--1.Find out how many new customers were acquired in the year 2014?

select * from OrdersList 

SELECT COUNT(*)as newcustomer2014 FROM (
select CustomerName,min(OrderDate)as FirstOrderDate 
from OrdersList 
GROUP BY CustomerName
HAVING YEAR(MIN(ORDERDATE))='2014' ) AS Customer1order2014 

--2.Calculate the percentage of total profit contributed by each sub-category to the overall profit.

select SubCategory,sum(profit) as SubcategoryProfit,
sum(Profit)/(select SUM(Profit) from EachOrderBreakdown)*100 as PercentageofTotalContribution
from EachOrderBreakdown
group by SubCategory 
order by PercentageofTotalContribution desc

--3.Find the average sales per customer, considering only customers who have made more than one order.

WITH CustomerAvgSales AS(
SELECT CustomerName, COUNT(DISTINCT ol.OrderID) As NumberOfOrders, AVG(Sales) AS AvgSales
FROM OrdersList ol
JOIN EachOrderBreakdown ob
ON ol.OrderID = ob.OrderID 
GROUP BY CustomerName
)
SELECT CustomerName, AvgSales
FROM CustomerAvgSales
WHERE NumberOfOrders > 1 

--4.Identify the top-performing subcategory in each category based on total sales. Include the sub-category name, total sales, and a ranking of sub-category within each category.

WITH topsubcategory AS(
SELECT Category, SubCategory, SUM(sales) as TotalSales,
RANK() OVER(PARTITION BY Category ORDER BY SUM(sales) DESC) AS SubcategoryRank
FROM EachOrderBreakdown
Group By Category, SubCategory
)
SELECT *
FROM topsubcategory
WHERE SubcategoryRank = 1
