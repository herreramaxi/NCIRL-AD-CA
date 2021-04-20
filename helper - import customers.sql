SET IDENTITY_INSERT [dbo].[Customers] ON

Insert into dbo.Customers([Id],[CustomerTypeId],[FirstName],[LastName],[PhoneNo], [AddressLine1], [City], [Country])
select 
distinct 
TOP 50
ROW_NUMBER() OVER (ORDER BY c.CustomerID) as Id,
case when c.CustomerID % 2 = 0 then 10
else 11 end as CustomerTypeId,
FirstName,	
LastName,
Phone as PhoneNo,
a.AddressLine1,
a.City,
a.CountryRegion as Country
from AdventureWorksLT2014.SalesLT.Customer c
inner join AdventureWorksLT2014.SalesLT.CustomerAddress ca on ca.CustomerID = c.CustomerID
inner join AdventureWorksLT2014.SalesLT.Address a on a.AddressID = ca.AddressID

SET IDENTITY_INSERT [dbo].[Customers] OFF