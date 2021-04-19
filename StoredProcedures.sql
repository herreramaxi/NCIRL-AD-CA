CREATE PROCEDURE CreateCustomerAndAssociation   
	@FirstName nvarchar(20),
   @LastName nvarchar(20), 
	@AddressLine1 nvarchar(20),
	@City nvarchar(20),
	@Country nvarchar(20),
	@PhoneNo nvarchar(10),
	@CustomerTypeId int,
	@CustomerId2 int,
	@AssociationTypeId int
AS   

	INSERT INTO [dbo].[Customers]([CustomerTypeId],[FirstName],[LastName],[PhoneNo],[AddressLine1],[City],[Country]) 
	VALUES (@CustomerTypeId,@FirstName, @LastName,@PhoneNo,@AddressLine1, @City, @Country)

	DECLARE @customerId AS INT = @@IDENTITY 
	
	INSERT INTO [dbo].[Associations] ([Customer1Id],[Customer2Id],[ReferenceDataId]) VALUES (@customerId, @CustomerId2, @AssociationTypeId)

GO  

CREATE PROCEDURE DeleteCustomer @CustomerId int   
AS   				
	DELETE FROM [dbo].[Associations] WHERE Customer1Id = @customerId OR Customer2Id = @customerId
	DELETE FROM [dbo].[Accounts] WHERE customerId = @customerId	
	DELETE FROM [dbo].[Customers] WHERE Id= @customerId	
GO  


CREATE VIEW dbo.vwCustomersAssociations
WITH SCHEMABINDING
AS
	SELECT	c1.FirstName + ' ' + c1.LastName + ' is '+ r.Description  + ' of ' + c2.FirstName + ' ' + c2.LastName AS CustomersAssociation
	FROM	[dbo].[Associations] a
			INNER JOIN [dbo].[Customers]		c1	ON	c1.Id = a.Customer1Id
			INNER JOIN [dbo].[Customers]		c2	ON	c2.Id = a.Customer2Id
			INNER JOIN [dbo].[ReferenceData]	r	ON	r.Id = a.ReferenceDataId


CREATE VIEW dbo.vwReferenceDataDeleted
WITH SCHEMABINDING
AS
	SELECT  r.Id,
			r.Description
	FROM	[dbo].[ReferenceData] r
	WHERE	r.IsDeleted = 1