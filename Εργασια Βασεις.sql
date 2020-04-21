
DECLARE @MyDatetime datetime

CREATE TABLE Area
				(area_code INTEGER,
				populationn INTEGER,
				area_name CHAR(20),
				PRIMARY KEY (area_code));

CREATE TABLE Category
				(category_code INTEGER,
				category_description CHAR(20),
				PRIMARY KEY (category_code));
				
CREATE TABLE Product
				(product_code INTEGER,
				price REAL,
				product_name CHAR(20),
				product_quantity INTEGER,
				product_descript CHAR(20),
				category_code INTEGER,
				PRIMARY KEY (product_code), 
				FOREIGN KEY (category_code) REFERENCES Category);

CREATE TABLE Supplier
				(supplier_code INTEGER,
				supplier_phone CHAR(20),
				supplier_VAT INTEGER,
				supplier_name CHAR(20),
				supplier_adress CHAR(20),
				area_code INTEGER,
				PRIMARY KEY (supplier_code),
				FOREIGN KEY (area_code) REFERENCES Area);

CREATE TABLE Supply
				(supply_code INTEGER,
				supply_date datetime,
				supply_quantity INTEGER,
				product_code INTEGER,
				supplier_code INTEGER,
				PRIMARY KEY (supply_code),
				FOREIGN KEY (supplier_code) REFERENCES Supplier);


CREATE TABLE Customer
				(customer_code INTEGER,
				customer_VAT INTEGER,
				customer_address CHAR(20),
				customer_phone CHAR(20),
				customer_name CHAR(20),
				area_code INTEGER,
				PRIMARY KEY (customer_code),
				FOREIGN KEY (area_code) REFERENCES Area);

CREATE TABLE Regular 
				(customer_code INTEGER,
				balance REAL,
				credit_limit REAL,
				FOREIGN KEY (customer_code) REFERENCES Customer);

CREATE TABLE Oorder
				(order_code INTEGER,
				customer_code INTEGER,
				order_date datetime,
				delivery_date datetime,
				PRIMARY KEY (order_code),
				FOREIGN KEY (customer_code) REFERENCES Customer);

CREATE TABLE Containss
				(product_code INTEGER,
				order_code INTEGER,
				quantity INTEGER,
				PRIMARY KEY (product_code,order_code),
				FOREIGN KEY (product_code) REFERENCES Product,
				FOREIGN KEY (order_code) REFERENCES Oorder);

CREATE TABLE Payment
				(payment_code INTEGER,
				customer_code INTEGER,
				payment_amount REAL,
				payment_date datetime,
				PRIMARY KEY (payment_code,customer_code),
				FOREIGN KEY (customer_code) REFERENCES Customer);


Alter Table Area Alter Column  area_code INTEGER not null;
Alter Table Area add constraint CHECK_population CHECK(populationn>0); 

Alter Table Category Alter Column  category_code INTEGER not null;

Alter Table Product Alter Column  product_code INTEGER not null;
Alter Table Product add constraint CHECK_price CHECK (price>0.0);
Alter Table Product add constraint CHECK_product_quantity CHECK (product_quantity>=0);
Alter Table Product Alter Column  product_quantity INTEGER not null;

Alter Table Supplier Alter Column  supplier_code INTEGER not null;
Alter Table Supplier Alter Column  area_code INTEGER not null;
Alter Table Supplier add constraint UQ_supplier_phone unique(supplier_phone);
Alter Table Supplier add constraint UQ_supplier_VAT unique(supplier_VAT);

Alter Table Supply Alter Column  supply_code INTEGER not null;
Alter Table Supply add constraint CHECK_supply_quantity CHECK(supply_quantity>0);
/*Alter Table Supply add constraint UQ_prod_code unique(product_code);*/
Alter Table Supply Alter Column  supplier_code INTEGER not null;

Alter Table Customer Alter Column customer_code INTEGER not null;
Alter Table Customer Alter Column  area_code INTEGER not null;
Alter Table Customer add constraint UQ_customer_phone unique(customer_phone);
Alter Table Customer add constraint UQ_customer_VAT unique(customer_VAT);

Alter Table Regular add constraint CHECK_balance CHECK(balance>=0.0);
Alter Table Regular add constraint CKECK_credit_limit CHECK(credit_limit>=0.0);
Alter Table Regular add  Constraint CHECK_credit_balance CHECK (balance<=credit_limit);
Alter Table Regular Alter Column customer_code INTEGER not null;


Alter Table Oorder Alter Column order_code INTEGER not null;
Alter Table Oorder Alter Column  customer_code INTEGER not null;
Alter Table Oorder add constraint CHECK_order_delivery CHECK (order_date<=delivery_date);

Alter Table Containss Alter Column  product_code INTEGER not null;
Alter Table Containss add constraint CHECK_quantity CHECK(quantity>=0.0);

Alter Table Payment Alter Column  payment_code INTEGER not null;
Alter Table Payment add constraint CHECK_payment_amount CHECK(payment_amount>0.0);

Insert into Area (area_code, populationn, area_name) values (0001, 664046, 'Athens');
Insert into Area (area_code, populationn, area_name) values (0002, 623065, 'Crete');
Insert into Area (area_code, populationn, area_name) values (0003, 51320, 'Chios');

Insert into Category (category_code, category_description) values (0010, 'clothing');
Insert into Category (category_code, category_description) values (0011, 'footwear');
Insert into Category (category_code, category_description) values (0012, 'accessories');

Insert into Product (product_code,price, product_name, product_quantity,product_descript,category_code) values (0100,40.0,'trouser',20,'color black size M',0010);
Insert into Product (product_code,price, product_name, product_quantity,product_descript,category_code) values (0101,35.0,'sneaker',10,'color grey size 37',0011);
Insert into Product (product_code,price, product_name, product_quantity,product_descript,category_code) values (0102,60.0,'belt',12,'brown leather',0012);
Insert into Product (product_code,price, product_name, product_quantity,product_descript,category_code) values (0103,10.0,'T-shirt',28,'white ',0010);
Insert into Product (product_code,price, product_name, product_quantity,product_descript,category_code) values (0104,10.0,'Cargo pants',30,'dark grey ',0010);


Insert into Supplier (supplier_code, supplier_phone, supplier_VAT, supplier_name, supplier_adress, area_code) values (1000,'6949420043', 51981234,'Kostas Papadopoulos', 'Ag.Alexandrou 2',0001 );
Insert into Supplier (supplier_code, supplier_phone, supplier_VAT, supplier_name, supplier_adress, area_code) values (1001,'6981650344', 12866215, 'Alexis Aggelakis','Xatzidaki 62', 0002);
Insert into Supplier (supplier_code, supplier_phone, supplier_VAT, supplier_name, supplier_adress, area_code) values (1002,'6934565112', 02561728, 'Athina Papathanasiou' ,'Metaxa 40', 0003);
Insert into Supplier (supplier_code, supplier_phone, supplier_VAT, supplier_name, supplier_adress, area_code) values (1003,'6934545002', 12254628, 'Nikos Makris' ,'Palaiologou 40', 0001);

Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2000, 1000, 0100, '2010-02-12 10:34:09', 4000);
Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2001, 1001, 0101, '2010-03-15 06:15:18', 5000);
Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2002, 1002, 0102, '2010-05-21 15:23:45', 5000);
Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2003, 1002, 0101, '2010-05-22 15:23:45', 500);
Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2004, 1003, 0100, '2010-07-22 15:23:45', 500);
Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2005, 1003, 0103, '2010-07-22 15:23:45', 500);
Insert into Supply (supply_code, supplier_code, product_code, supply_date, supply_quantity) values (2006, 1003, 0104, '2010-07-22 15:23:45', 500);

Insert into Customer (customer_code, customer_VAT, customer_address, customer_phone, customer_name, area_code) values (3000, 87456324, 'Kidonion 21', '6947666152', 'Kostas Xatzipetrou', 0001);
Insert into Customer (customer_code, customer_VAT, customer_address, customer_phone, customer_name, area_code) values (3001,14529081, 'Ahdiniou 26', '6933231897', 'Marina Chryssikou', 0002);
Insert into Customer (customer_code, customer_VAT, customer_address, customer_phone, customer_name, area_code) values (3002, 32145624, 'Patision 80', '6942551610', 'Ioannis Melaxrinos', 0003);
Insert into Customer (customer_code, customer_VAT, customer_address, customer_phone, customer_name, area_code) values (3003, 76819267, 'Omhrou 8', '6981265543', 'Anna Alexopoulou', 0001);
Insert into Customer (customer_code, customer_VAT, customer_address, customer_phone, customer_name, area_code) values (3004, 76819266, 'Omhrou 8', '6981265544', 'Anna Alexopoulou', 0001);

Insert into Regular (customer_code, balance, credit_limit) values (3000, 52.12, 10000.0);
Insert into Regular (customer_code, balance, credit_limit) values (3001, 120.0, 9000.0);

Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4000, 3000, '2017-12-09 18:55:02', '2017-12-17 20:34:25');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4001, 3001, '2017-02-28 16:10:54', '2017-03-06 18:56:00');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4002, 3002, '2017-04-12 19:08:19', '2017-04-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4003, 3000, '2012-01-12 19:08:19', '2012-04-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4004, 3000, '2012-01-18 19:08:19', '2012-04-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4005, 3001, '2012-01-19 19:19:19', '2012-02-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4006, 3003, '2012-12-09 18:55:02', '2012-12-17 20:34:25');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4007, 3002, '2013-01-09 18:55:02', '2013-01-17 20:34:25');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4008, 3002, '2013-01-19 18:55:02', '2013-01-27 20:34:25');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4009, 3000, '2013-01-19 18:55:02', '2013-01-27 20:34:25');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4010, 3002, '2013-01-22 18:55:02', '2013-01-27 20:34:25');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4011, 3001, '2012-02-12 19:08:19', '2012-02-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4012, 3001, '2012-03-12 19:08:19', '2012-03-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4013, 3000, '2012-04-12 19:08:19', '2012-04-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4014, 3002, '2012-05-12 19:08:19', '2012-05-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4015, 3000, '2011-01-12 19:08:19', '2011-04-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4016, 3001, '2011-02-12 19:08:19', '2011-02-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4017, 3001, '2011-03-12 19:08:19', '2011-03-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4018, 3000, '2011-04-12 19:08:19', '2011-04-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4019, 3002, '2011-05-12 19:08:19', '2011-05-18 19:18:03');
Insert into Oorder (order_code, customer_code, order_date, delivery_date) values (4020, 3002, '2011-05-12 19:08:19', '2011-05-18 19:18:03');


Insert into Containss (product_code, order_code, quantity) values (0100, 4000, 55);
Insert into Containss (product_code, order_code, quantity) values (0101, 4001, 50);
Insert into Containss (product_code, order_code, quantity) values (0102, 4002, 10);
Insert into Containss (product_code, order_code, quantity) values (0102, 4003, 45);
Insert into Containss (product_code, order_code, quantity) values (0101, 4004, 10);
Insert into Containss (product_code, order_code, quantity) values (0100, 4005, 30);
Insert into Containss (product_code, order_code, quantity) values (0100, 4006, 30);
Insert into Containss (product_code, order_code, quantity) values (0100, 4007, 30);
Insert into Containss (product_code, order_code, quantity) values (0100, 4008, 40);
Insert into Containss (product_code, order_code, quantity) values (0101, 4009, 40);
Insert into Containss (product_code, order_code, quantity) values (0101, 4010, 30);
Insert into Containss (product_code, order_code, quantity) values (0101, 4011, 4);
Insert into Containss (product_code, order_code, quantity) values (0100, 4012, 2);
Insert into Containss (product_code, order_code, quantity) values (0100, 4013, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4014, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4015, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4016, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4017, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4018, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4019, 5);
Insert into Containss (product_code, order_code, quantity) values (0100, 4020, 5);
Insert into Containss (product_code, order_code, quantity) values (0103, 4020, 5);
Insert into Containss (product_code, order_code, quantity) values (0104, 4020, 5);

Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5000, 3000, 150.0, '2017-04-12 19:08:19');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5001, 3001, 200.0, '2017-05-23 09:18:05');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5002, 3001, 600.0, '2012-05-14 18:08:01');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5003, 3000, 800.0, '2012-05-18 09:12:21');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5004, 3000, 255.0, '2012-05-22 10:08:21');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5005, 3000, 230.0,'2012-01-22 12:10:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5006, 3000, 220.0,'2012-01-25 12:12:12');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5007, 3001, 220.0,'2012-02-25 12:18:16');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5008, 3001, 220.0,'2012-02-28 15:20:16');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5009, 3001, 220.0,'2012-03-18 12:19:12');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5010, 3001, 250.0,'2012-03-25 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5011, 3001,  25.0,'2012-04-25 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5012, 3001,  25.0,'2012-04-28 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5013, 3000,  80.0,'2012-06-25 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5014, 3000,  80.0,'2012-06-25 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5015, 3000,  80.0,'2012-07-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5016, 3001,  90.0,'2012-08-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5017, 3001, 100.0,'2012-09-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5018, 3001,  90.0,'2012-09-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5019, 3000,  190.0,'2012-10-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5020, 3000,   90.0,'2012-11-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5021, 3001,   50.0,'2012-12-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5022, 3001,   60.0,'2012-12-20 12:19:10');
Insert into Payment (payment_code, customer_code, payment_amount, payment_date) values (5023, 3001,   90.0,'2012-12-20 12:19:10');

/* 1 */
select customer_code , customer_VAT , customer_name, customer_address, customer_phone
From Customer

/* 2 */
select customer_code, payment_amount
From Payment
Where payment_date between '2012-05-11' and '2012-05-23'

/* 3 */
Select  Oorder.order_date ,Oorder.order_code,Containss.product_code
From Oorder, Containss
Where  Oorder.order_code=Containss.order_code

/* 4 */
Update Product
Set price=price*1.03

/* 5 */
select month(payment_date), sum(payment_amount), avg(payment_amount)
From Payment
Where year(payment_date)=2012
Group by month(payment_date)

/* 6 */
Go
Create view V6 (cust_code) as
Select C.customer_code
From Customer as C ,Oorder as O, Product as P, Containss as Cc
Where  C.customer_code = O.customer_code AND 
month(O.order_date)=1 AND year(O.order_date)= 2013 AND Cc.product_code=P.product_code AND  O.order_code=Cc.order_code 
Group by C.customer_code
Having  sum(Cc.quantity*P.price)>2500
Go

Select customer_VAT,customer_name
From V6,Customer
Where V6.cust_code= Customer.customer_code

Drop view V6;

/* 7 */ 

Select C.customer_code , Ca.category_code,sum(Cc.quantity*P.price)
From Customer as C ,Oorder as O, Product as P, Containss as Cc, Category as Ca
Where  C.customer_code = O.customer_code AND
		Cc.product_code=P.product_code AND
		 O.order_code=Cc.order_code AND 
		 Ca.category_code=P.category_code
 Group by Ca.category_code , C.customer_code

/* 8 */ 
 Select A.area_code,C.category_code,sum(P.price*Cc.quantity)
From Area as A, Category as C , Product as P, Containss as Cc,Customer as Cu
Where P.category_code=C.category_code AND  A.area_code=Cu.area_code AND P.product_code = Cc.product_code 
Group by A.area_code, C.category_code

 Select Cu.area_code,P.category_code,sum(P.price*Cc.quantity)
From   Product as P, Containss as Cc,Customer as Cu
Where  P.product_code = Cc.product_code 
Group by Cu.area_code, P.category_code

/* 9 */
Go
 Create view V9a (month,sum_amount) as
Select month(O.order_date),sum(Cc.quantity*P.price)
From Product as P , Oorder as O , Containss as Cc 
Where P.product_code=Cc.product_code AND O.order_code=Cc.order_code AND year(O.order_date)=2012 
Group by month(O.order_date)
Go

Go
create view V9b(sum_amount) as                            
select  sum(quantity*price)
from Product as P , Oorder as O , Containss as Cc
Where P.product_code=Cc.product_code AND O.order_code=Cc.order_code AND year(O.order_date)=2012 
Go

select  V9a.month, V9a.sum_amount/V9b.sum_amount
from V9a, V9b


DROP view V9a;
DROP view V9b;

/* 10 */

Go
Create View V10a(month,avg_amount) as
Select month(order_date), avg(quantity*price)
From Oorder as O , Containss as C ,Product as P
Where (O.order_code=C.order_code) AND (C.product_code=P.product_code)
Group by month(order_date)
Go

Go
Create view V10b (month, cust_code,  avg_amount) as
Select  month(order_date),Cu.customer_code,  avg(quantity*price)
From Customer as Cu , Oorder as Oo, Containss as Cc ,Product as P
Where (Cu.customer_code=Oo.customer_code) AND (Oo.order_code=Cc.order_code)
AND (Cc.product_code=P.product_code)
Group by  month(Oo.order_date),Cu.customer_code
Go

 Select 10a.month, Count(cust_code)
From V10a, V10b
Where  (V10a.month=V10b.month) AND (V10b.avg_amount>K1.avg_amount)
Group by V10a.month

DROP view V10a;
DROP view V10b;

/* 11 */
Go
Create view V11a(month,sum_amount) as
Select month(O.order_date),sum(Cc.quantity*P.price)
From Product as P , Oorder as O , Containss as Cc 
Where P.product_code=Cc.product_code AND O.order_code=Cc.order_code AND year(O.order_date)=2012
Group by month(O.order_date)
Go

Go
Create view V11b(month,sum_amount) as
Select month(O.order_date),sum(Cc.quantity*P.price)
From Product as P , Oorder as O , Containss as Cc 
Where P.product_code=Cc.product_code AND O.order_code=Cc.order_code AND year(O.order_date)=2011
Group by month(O.order_date)
Go

select V11a.month, V11a.sum_amount/V11b.sum_amount
from V11a, V11b
where V11a.month=V11b.month

DROP view V11a;
DROP view V11b;

/* 12 */

Go
Create view V12a (months,total_amount,count_orders) as
Select month(O.order_date),sum(P.price*Cc.quantity),count(O.order_code)
From Containss as Cc,Product as P,Oorder as O 
Where O.order_code=Cc.order_code AND P.product_code=Cc.product_code AND year(O.order_date)=2012
Group by month(O.order_date)
Go

Go 
Create view V12b (months,total_amount,count_orders) as
Select O1.months,sum(O2.total_amount),sum(O2.count_orders)
From V12a as O1, V12a as O2
where O2.months< O1.months
Group by O1.months
Go

Select V12a.months,V12a.total_amount/V12a.count_orders,V12b.total_amount/V12b.count_orders
From V12a 
LEFT OUTER JOIN  V12b
ON V12a.months = V12b.months

SELECT  V12a.months,V12a.total_amount/V12a.count_orders,V12b.total_amount/V12b.count_orders
From V12a , V12b
Where V12a.months = V12b.months

/* 13 */

 Go
 Create view V13(product,area) as
 Select P.product_code,Su.area_code
 From Supplier as Su,Supply as S, Product as P
 Where S.supplier_code = Su.supplier_code AND S.product_code=P.product_code
 Group by P.product_code,Su.area_code
 Go

 Select V13.product
 From V13 
 Group by V13.product
 Having count(V13.product)=1

/* 14 */

Select O.order_code 
From Oorder as O, Supply as S, Containss as C
Where O.order_code=C.order_code AND S.product_code=C.product_code
Group by O.order_code,S.supplier_code
Having count(C.product_code)>=3


/*3o Παραδοτεο*/


/*1*/


Create procedure area_info
@areacode int 
AS
Select count(customer_code)
From Customer
Where area_code=@areacode
Group by area_code
GO

EXECUTE area_info 1

/*2*/
Create procedure product_info
@prodcode int,
@date1 datetime,
@date2 datetime
As
Declare
@descript char(20), 
@supplycode int,
@quantity int,
@date datetime
declare cursor_name_1 cursor
For Select product_descript
From Product 
Where product_code=@prodcode
open cursor_name_1
fetch cursor_name_1 into @descript
while @@FETCH_STATUS=0
Begin 
print @descript 
Fetch next from cursor_name_1 into @descript
end 
close cursor_name_1
deallocate cursor_name_1

declare cursor_name cursor
for Select supply_code ,supply_quantity,supply_date
From Supply
Where product_code=@prodcode
AND supply_date>=@date1 AND supply_date<=@date2
open cursor_name
fetch cursor_name into @supplycode,@quantity,@date
WHILE @@FETCH_STATUS = 0  
BEGIN 

	PRINT  @supplycode 
	 PRINT @quantity 
	 PRINT  @date
	Fetch Next  From cursor_name Into @supplycode,@quantity,@date
End
close cursor_name
Deallocate cursor_name
Go
EXECUTE product_info 0100, '2010-07-22 15:23:45','2010-07-25 15:23:45'
