--Q1 Establish the relationship between the tables as per the ER diagram.

Alter Table OrdersList 
alter column OrderId nvarchar(255) not null

Alter Table OrdersList
add constraint pk_orderid primary key (OrderId)

Alter Table EachOrderBreakdown
alter column OrderId nvarchar(255) not null

Alter Table EachorderBreakdown
add constraint fk_orderid foreign key (OrderId) references OrdersList(orderid)

--Q2. Split City State Country into 3 individual columns namely ‘City’, ‘State’, ‘Country’.

alter table OrdersList 
add City nvarchar(255),
    State nvarchar(255),
    Country nvarchar(255);  

update OrdersList 
SET City = PARSENAME(replace([City State Country],',','.'),3),
    State = PARSENAME(replace([City State Country],',','.'),2),
	Country =  PARSENAME(replace([City State Country],',','.'),1)

ALTER TABLE Orderslist 
drop column [City State Country]

select* from OrdersList

--Q3. Add a new Category Column using the following mapping as per the first 3 characters in the Product Name Column:
--TEC- Technology
--OFS – Office Supplies
--FUR - Furniture 


select * from EachOrderBreakdown

alter table EachOrderBreakdown
ADD Category nvarchar(255)

update EachOrderBreakdown
set Category = CASE WHEN LEFT(ProductName,3) = 'OFS' THEN 'Office Supplies' 
                    WHEN LEFT(ProductName,3) = 'FUR' THEN 'Furniture '
					WHEN LEFT(ProductName,3) = 'TEC' THEN 'Technology'
			    END; 

--Q4. Delete the first 4 characters from the ProductName Column.

UPDATE EachOrderBreakdown 
SET ProductName = SUBSTRING(ProductName,5,LEN(ProductName)-4)

--Q5. Remove duplicate rows from EachOrderBreakdown table, if all column values are matching

WITH CTE AS (
SELECT *, ROW_NUMBER() OVER(PARTITION by OrderId,Discount,Sales,Profit,Quantity,Category,SubCategory order by OrderId)as ROW_N
 FROM EachOrderBreakdown
   ) 
   DELETE FROM CTE 
   WHERE ROW_N  > 1 

  --Q6. Replace blank with NA in OrderPriority Column in OrdersList table. 

  SELECT * FROM OrdersList
  UPDATE OrdersList 
  SET OrderPriority = 'N/A'
  WHERE OrderPriority = '';






