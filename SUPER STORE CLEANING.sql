
--Q1 Establish a relationship between the tables as per ER diagram .

ALTER TABLE OrdersList
ALTER COLUMN ORDERID nvarchar(255) not null

ALTER TABLE OrdersList
ADD CONSTRAINT pk_orderid primary key (orderid) -- changing column to primarykey which by default is n .


ALTER TABLE EachOrderBreakdown
ALTER COLUMN ORDERID nvarchar(255) not null

ALTER TABLE EachOrderBreakdown
add CONSTRAINT fk_orderid foreign key(orderid) references Orderslist(orderid) --defining foreign key.

 --Q2 split city state country into 3 individual columns .

alter table orderslist 
add City nvarchar(255),
    State nvarchar(255),
	Country nvarchar(255); 

update orderslist 
set City = PARSENAME(REPLACE([City State Country],',','.'),3),
    State = PARSENAME(REPLACE([City State Country],',','.'),2),
	Country = PARSENAME(REPLACE([City State Country],',','.'),1);

select * from orderslist

