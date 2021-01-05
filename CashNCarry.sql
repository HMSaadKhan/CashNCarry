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
						

--INSERT INTO Employees (First_Name, Last_Name, Contact_Number, DOB, salary, Hire_Date, Employee_Status, E_Address, City) VALUES  
--INSERT INTO Customers (First_Name, Last_Name, Contact_NUmber) VALUES 
--INSERT INTO Category (Category_Name) VALUES
--INSERT INTO Supplier(CompanyName, First_Name, Last_Name, Contact_Number, Supplier_Address, City) VALUES
--INSERT INTO Products (Product_Name, Supplier_ID, Catergory_ID, Purchase_Price,Sales_Price, Product_Stock)
--VALUES INSERT INTO Orders (Customer_ID, Employee_ID) VALUES 
--INSERT INTO Orders_Details(Order_ID, Product_ID, Product_Quantity) VALUES 
--INSERT INTO Products_Ordered (Product_ID, products_Ordered) values
 

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
