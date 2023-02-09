--Spieltabelle

USE NORTHWIND
GO

SELECT Customers.CustomerID, Customers.CompanyName, Customers.ContactName, 
Customers.ContactTitle, Customers.City, Customers.Country, Orders.OrderDate, Orders.EmployeeID, Orders.
Freight, Orders.ShipName,Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].
ProductID, [Order Details].UnitPrice, [Order Details].Quantity, 
Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName 
INTO KU 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID 
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID 
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 
GO

insert into KU
select * from ku
GO 9 
--6 Sek... im Gegensatz zu 20000 mit Go  20 Sek
--wiederhole bis ca 1,1 Mio DS


alter table ku add id int identity --dauert
