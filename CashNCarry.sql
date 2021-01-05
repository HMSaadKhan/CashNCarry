create database CashNCarry
use CashNCarry

create table Customers(
			Customer_ID int Identity(1,1) primary key,
			First_Name varchar(50) Not Null,
			Last_Name varchar(50)  Null,
			Contact_NUmber bigint Null)

create table Employees(
			Employee_ID int Identity(1,1) primary key,
			First_Name varchar(50) Not Null,
			Last_Name varchar(50)  Not Null,
			Contact_Number bigint Not Null,
			DOB Date not null,
			Hire_Date Date not null,
			E_Address varchar(50) Not Null,
			City varchar(15)  Not Null,
			Employee_Status varchar(15) not null,
			salary int not null)

create table Category(
			Category_ID int Identity(1,1) primary key,
			Category_Name varchar(50) Not Null		)


create table Supplier(
			Supplier_ID int Identity(1,1) primary key,
			CompanyName varchar(50) Not Null,
			First_Name varchar(50) Not Null,
			Last_Name varchar(50)  Not Null,
			Contact_Number bigint Not Null,
			Supplier_Address varchar(50) Not Null,
			City varchar(15)  Not Null)


Create table Products(
			Product_ID int Identity(1,1) primary key,
			Product_Name varchar(50) Not Null,
			Supplier_ID int foreign key references Supplier(Supplier_ID),
			Catergory_ID int foreign key references Category(Category_ID),
			Purchase_Price int not null,
			Sales_Price int not null,
			Product_Stock int null) 

Create table Products_Ordered(
			Product_Ordered_ID int Identity(1,1) primary key,
			Product_ID int foreign key references Products(Product_ID),
			products_Ordered int not null,
			ordered_date date not null default GetDate()) 



Create table Orders(
			Order_ID int Identity(1,1) primary key,
			Customer_ID int foreign key references Customers(Customer_ID),
			Employee_ID int foreign key references Employees(Employee_ID),
			Order_Date date not null default GETDATE()) 

Create table Orders_Details(
			Order_ID int foreign key references Orders(Order_ID),
			Product_ID int foreign key references Products(Product_ID),
			Product_Quantity int not null,
			Constraint PK_Orders_Detail Primary key(Order_ID,Product_ID))
						

INSERT INTO Employees (First_Name, Last_Name, Contact_Number, DOB, salary, Hire_Date, Employee_Status, E_Address, City)
VALUES ('Shahbaz', 'Ansar', 345347, '1988-05-18', 18000, '2019-03-08', 'Expired', 'Kamahan', 'Sialkot'),
		
	   ('Shahzad', 'Gill', 577347,'1986-06-19', 18000, '2019-04-04', 'Active', 'Cantt', 'Sialkot'),

		('Arshad', 'Chaudhry', 577456, '1990-07-16', 18000, '2019-03-08', 'Active', 'Gulberg', 'Lahore'),
		('Adnan', 'Ali', 579856, '2000-09-11', 18000, '2019-09-13', 'Active', 'Cavalry', 'Lahore'),
		('Ashraf', 'Mumtaz', 245674, '1996-06-26', 18000, '2019-11-08' , 'Active', 'Shadbag', 'Lahore')

 
INSERT INTO Customers (First_Name, Last_Name, Contact_NUmber)
VALUES ('fahad', 'Ashfaq', 76343456),
	 ('Ahmed', 'Shahzad', 92345355698),
	 ('Ali', 'Subhani', 9234500698),
	 ('Lareeb', 'Ahmed', 9276700456),
	 ('Aisha', 'Riaz', 9250090456),
	 ('Alishba', 'Ismail', 9365470456),
	 ('Talha', 'Tariq', 8365423456),
	 ('Maaz',	'Iqbal', 8312343456),
	 ('Saad',	'Khan',	7654343456),
	 ('Aitesam', 'Javed', 8674343456),
	 ('Ahmad', 'Ashfaq', 76343456),
	 ('talha', 'Shahzad', 92345355698),
	 ('maaz', 'Subhani', 9234500698),
	 ('fatima', 'Ahmed', 9276700456),
	 ('Ahsan', 'Riaz', 9250090456),
	 ('Alishba', 'Arif', 9365470456),
	 ('Talha', 'Tariq', 8365423456),
	 ('Maaz',	'Iqbal', 8312343456),
	 ('Saad',	'Khan',	7654343456),
	 ('Aitesam', 'Javed', 8674343456),
     ('fahad', 'Ashfaq', 76343456),
	 ('Ahmed', 'Shahzad', 92345355698),
	 ('Ali', 'Subhani', 9234500698),
	 ('Lareeb', 'Ahmed', 9276700456),
	 ('Aisha', 'Riaz', 9250090456),
	 ('Alishba', 'Ismail', 9365470456),
	 ('Talha', 'Tariq', 8365423456),
	 ('Maaz',	'Iqbal', 8312343456),
	 ('Saad',	'Khan',	7654343456),
	 ('Aitesam', 'Javed', 8674343456)

INSERT INTO Category (Category_Name)
VALUES ('Food Items'), 
 ('Utilities'),
 ('Appliances'),
('Cosmetics')

INSERT INTO Supplier(CompanyName, First_Name, Last_Name, Contact_Number, Supplier_Address, City)
VALUES ('Nestle', 'Usman', 'Umar', 876543, 'Defence', 'Karachi'),
 ('Pepsico', 'Zaid', 'Shah', 987543, 'Clifton', 'Karachi'),
('Nivea', 'Faizan', 'Tariq', 123443, 'Raiwind', 'Faisalabad'),
 ('Phillips', 'Sherry', 'Aun', 657443, 'Walton',	'Lahore'),
 ('Garnier', 'Saim', 'Mujahid', 234443, 'Peco',	'Lahore'),
 ('Cadbury', 'Osama', 'Mumtaz', 987443, 'Peero', 'Multan'),
('Dawn', 'Azib', 'Shahzad', 786543, 'Saghian', 'Lahore')

INSERT INTO Products (Product_Name, Supplier_ID, Catergory_ID, Purchase_Price,
			Sales_Price, Product_Stock)
VALUES ('Milk',	1, 1, 100, 150, 105),
 ('Drinks', 2, 1, 100, 120, 120),
('Cake', 7, 1, 40, 50, 10),
 ('Bread', 7, 1, 80, 100, 50),
 ('Soap', 5, 2, 60, 70, 30),
 ('PaperRoll', 4, 2, 40, 50, 100),
 ('Oats', 1, 1, 70, 80, 100),
 ('Ice-cream', 6, 1, 40, 50, 150),
 ('Juice', 1, 1,40, 60, 100),
 ('LED',3, 3, 200, 300, 20),
 ('Charger', 3, 3,2000, 2200, 10),
 ('Remote', 3, 3, 1000, 1200, 20),
 ('Data-Cable', 3, 3, 300, 350, 10),
 ('Face-Wash', 5, 4, 300, 325, 30),
 ('Body_Spray', 5, 4, 400, 500, 10),
 ('Lips-Stick', 5, 4, 200, 250, 30),
 ('Perfumes', 5, 4, 1000, 1300, 40),
('Yougart', 1, 1, 80, 100, 15),
('Chocolate', 6, 1, 25, 40, 30),
('Biscuits', 7, 1, 20, 25, 30),
('Cards', 2, 2, 90, 100, 30)

INSERT INTO Orders (Customer_ID, Employee_ID)
VALUES (1, 2  ), (2, 3),
 (3, 2), (4, 2), (5, 5), (6, 5), (7, 3), (8, 3), (9, 4), (10, 2), (11, 2),  (12, 3), (13, 2),
 (14, 2), (15, 5),(16, 5),(17, 3), (18, 4), (19, 4), (20, 2), (21, 2), (22, 4), (23, 2), (24, 2),
 (25, 5), (26, 5), (27, 3), (28, 3),(29, 4), (30, 2)

INSERT INTO Orders_Details(Order_ID, Product_ID, Product_Quantity)
VALUES (1, 1, 4),
 (1, 2, 3),
 (2, 8, 4 ),
(2, 5, 1),
 (3, 2, 3),
 (3, 8, 4 ),
 (3, 21,  1 ),
 (3, 9, 1 ),
 (3, 13, 2),
 (3, 4,  4 ),
 (4, 11,2 ),
 (5, 11 ,1 ),
 (5, 13,1 ),
 (5, 14, 1),
 (5, 16, 1),
 (6, 6,  2),
 (7, 18,  3),
 (7, 12, 2), 
 (8, 5,  1),
 (8, 21,  2), 
 (9, 9,  1),
 (9, 3,  2),
 (10, 8,  2),
 (11, 10, 4),
 (12, 2, 3),
 (12, 8, 4 ),
 (13, 21,  1 ),
 (13, 9, 1 ),
 (14, 13, 2),
 (14, 4,  4 ),
 (14, 11,2 ),
 (15, 11 ,1 ),
 (15, 13,1 ),
 (15, 14, 1),
 (15, 16, 1),
 (16, 6,  2),
 (17, 18,  3),
 (17, 12, 2), 
 (18, 5,  1),
 (18, 21,  2), 
 (19, 9,  1),
 (19, 3,  2),
 (20, 8,  2),
 (21, 10, 4),
 (22, 2, 3),
 (22, 8, 4 ),
 (23, 21,  1 ),
 (23, 9, 1 ),
 (23, 11,  1 ),
 (23, 19, 1 ),
 (24, 13, 2),
 (24, 12, 2),
 (24, 14,  4 ),
 (24, 21,2 ),
 (24, 4,  4 ),
 (24, 11,2 ),
 (25, 11 ,1 ),
 (25, 13,1 ),
 (25, 14, 1),
 (25, 16, 1),
 (25, 21 ,1 ),
 (25, 6,1 ),
 (25, 17, 1),
 (25, 12, 1),
 (26, 16,  2),
 (26, 6,  2),
 (27, 8, 4 ),
 (27, 18,  3),
 (27, 12, 2), 
 (27, 10,  3),
 (27, 21, 2), 
 (28, 5,  1),
 (28, 21,  2),
 (28, 4,  1),
 (28, 12,  2), 
 (28, 2, 3),
 (29, 10, 1),
 (29, 11,  1),
 (29, 9,  1),
 (29, 3,  2),
 (30, 8,  2)

INSERT INTO Products_Ordered (Product_ID, products_Ordered) values
 (1,5),
 (2,5),
 (3,5)



select * from Customers
select * from Employees
select * from Category
select * from Supplier
select * from Products
select * from Orders
select * from Orders_Details
select * from Products_Ordered



create nonclustered index index_employee
on Employees(City)

create nonclustered index index_customers
on Customers(First_Name)

create nonclustered index index_Products
on Products(Product_Name)

create nonclustered index index_Orders
on Orders(Customer_ID)

create nonclustered index index_Products_Ordered
on Products_Ordered(Product_ID, ordered_date)

create nonclustered index index_supplier
on Supplier(CompanyName)



----------------------------------------------------------------------------------------------------------------------
create view Bill_details 
as 
select  Employee_ID,dbo.Orders.Order_ID,Customer_ID,Product_Name, Sales_Price, Product_quantity from Orders_Details
inner join Products on Products.Product_ID = Orders_Details.Product_ID
inner join Orders on Orders.Order_ID = Orders_Details.Order_ID


declare @getCID int 
select @getCID=2

select  Employee_ID,Order_ID,Customer_ID,Product_Name,Sales_Price as Product_Price, Product_quantity ,Sales_Price * Product_quantity as total
from Bill_details WHERE Customer_ID=@getCID  

Select sum(Sales_Price * Product_quantity) as Payable_Amount
from Bill_details group by Customer_ID having Customer_ID=@getCID 

----------------------------------------------------------------------------------------------------------------------
CREATE view View_Stock
as
Select Product_Id,Product_Name, Product_Stock, CompanyName from Products
inner join Supplier on Supplier.Supplier_ID=Products.Supplier_ID


select * from View_Stock where Product_Stock<50

----------------------------------------------------------------------------------------------------------------------

create view Employee_Salaray
as
Select First_Name,Last_Name,salary, Employee_Status from Employees


select * from Employee_Salaray where Employee_Status='Active' 

----------------------------------------------------------------------------------------------------------------------
create view Monthly_Sale 
as 
select  Product_Name,Sales_Price, Product_quantity,Order_Date from Orders_Details
inner join Products on Products.Product_ID = Orders_Details.Product_ID
inner join Orders on Orders.Order_ID = Orders_Details.Order_ID

declare @getMonth int 
select @getMonth=8

Select  Product_Name ,sum(Product_Quantity) as total_Products,sum(Product_Quantity * Sales_price) as total_amount
from Monthly_Sale  where MONTH(Order_Date )= @getMonth group by Product_name 

Select  sum(Product_Quantity * Sales_price) as total_Sale_amount
from Monthly_Sale where MONTH(Order_Date )= @getMonth

----------------------------------------------------------------------------------------------------------------------------------
create view Purchase_Products
as
select Product_Name, Purchase_Price, products_Ordered,  ordered_date as Purchase_Date from Products 
inner join Products_Ordered on Products_Ordered.Product_ID=Products.Product_ID


declare @date as int
select @date=13

select Product_Name, Purchase_Price, products_Ordered as Products_Quantity, Purchase_Date from Purchase_Products  
where DAY(Purchase_Date)=@date 

select sum(purchase_price*products_Ordered) as Purchasing_Bill from Purchase_Products where DAY(Purchase_Date)=@date

----------------------------------------------------------------------------------------------------------------------------------
Create trigger bill_trigger
on Orders_Details
for Insert
as 
declare @CID as int;
declare @OID as int;
Select @OID=Order_ID from inserted; 
select @CID=(select Customer_ID from Orders where Order_ID=@OID) from inserted;
begin 

select  Employee_ID,Order_ID,Customer_ID,Product_Name,Sales_Price as Product_Price, Product_quantity ,Sales_Price * Product_quantity as total
from Bill_details where Customer_ID=@CID

Select sum (Sales_Price * Product_quantity) as Payable_Amount
from Bill_details group by Customer_ID having Customer_ID=@CID
end

-----------------------------------------------------------------------------------------------------------------------
create trigger update_stock_On_sale
on Orders_Details
for Insert
as 
declare @PID as int;
declare @qty as int;

select @qty=Product_Quantity from inserted; 
select @PID=Product_ID from inserted 

 begin 
 update Products
 set  Product_Stock= Product_Stock-@qty where Product_ID =@PID 
end
--------------------------------------------------------------------------------------------------------------------------


CREATE trigger update_stock_On_purchase
on Products_Ordered
for Insert
as 
declare @PID as int;
declare @qty as int;
select @PID=Product_ID from inserted 
select @qty= products_Ordered from inserted  

 begin   
	update Products
	 set  Product_Stock= Product_Stock+@qty where Product_ID=@PID;

end

---------------------------------------------------------------------------------------------------------------------------------

create Procedure cal_Profit 
@month as int,
@result int output
 
as
declare @E_salary int ;
declare @t_sale as int ;
declare @t_purchase as int ;

begin

select @E_salary= (select sum(salary) from Employees where Employee_Status='Active')

Select @t_purchase= (select sum(purchase_price*products_Ordered) as Purchasing_Bill from Purchase_Products where Month(Purchase_Date)=@month)

select @t_sale = (Select  sum(Product_Quantity * Sales_price) as total_Sale_amount from Monthly_Sale where MONTH(Order_Date )=@month )

select @result=@t_sale-@t_purchase-@E_salary
end

declare @get varchar(50)
 
exec cal_Profit 8,@get output

if (@get > 0) 
print('We have a profit of '+ @get + '$') 
if (@get < 0) 
print('We have a loss '+ @get + '$')
if (@get is null)
print('There is no purchase in this month')
-----------------------------------------------------------------------------------------------------------------------------------------------
--TEST COMMANDS

select * from Products

INSERT INTO Customers(First_Name,Last_Name,Contact_NUmber) VALUES('Saad', 'Khan', 03040303301)
INSERT INTO Orders(Customer_ID,Employee_ID) VALUES(32,3)
INSERT INTO Orders_Details(Order_ID,Product_ID,Product_Quantity) VALUES (32,1,6)


select * from Products_Ordered

 INSERT INTO Products_Ordered(Product_ID,products_Ordered) VALUES (1,6) 
