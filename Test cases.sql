--Test case: Customer cannot be associated to another customer more than once under the same Association Type.
--------------------------------------------------------------------------------------------------------------

INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (10, 40, 30)
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (10, 40, 31)

select * from  dbo.vwCustomersAssociations where [Customer1Id] = 10

--This should fail. Expected error: Violation of PRIMARY KEY constraint 'PK_Associations'. Cannot insert duplicate key in object 'dbo.Associations'. The duplicate key value is (10, 40, 30).
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (10, 40, 30)

--Test case: Visualize association details
------------------------------------------

SELECT * FROM dbo.vwCustomersAssociations

INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (32, 34, 35)

SELECT * FROM dbo.vwCustomersAssociations

--Test case: Create customer and association
--------------------------------------------

SELECT	* FROM	dbo.vwCustomersAssociations where Customer2Id = 20

exec CreateCustomerAndAssociation 
	@FirstName = 'Wanda',
             @LastName = 'Vernon', 
	@AddressLine1 = 'Belgrove Park', 
	@City = 'Dublin 5',
	@Country = 'Ireland',
	@PhoneNo = '0878940684',
	@CustomerTypeId = 20,
	@CustomerId2 = 20,
	@AssociationTypeId = 30

SELECT	* FROM	dbo.vwCustomersAssociations where Customer2Id = 20

--Test case: Delete a customer and foreign key records 
------------------------------------------------------

SELECT	* FROM	Associations WHERE Customer1Id = 32 or Customer2Id = 32
SELECT  * FROM	Accounts WHERE CustomerId = 32
SELECT  * FROM	Securities WHERE AccountId IN (SELECT  id FROM Accounts WHERE CustomerId = 32)
SELECT 	* FROM	Customers WHERE	id = 32

exec DeleteCustomer @CustomerId= 32

--Test case: Validate soft delete on ReferenceData
--------------------------------------------------

select * from dbo.vwReferenceDataDeleted

SELECT	* 
FROM 	Accounts a
INNER JOIN ReferenceData r ON r.id = a.AccountTypeId
WHERE 	a.id  IN (1,2,3)

UPDATE dbo.ReferenceData SET IsDeleted = 1 WHERE id IN (1,2,3)

select * from dbo.vwReferenceDataDeleted

--Test case: No modifications can be done on underlying schema of view vwCustomersAssociations
----------------------------------------------------------------------------------------------

--This should fail. Expected error: Object 'dbo.Customers.FirstName' cannot be renamed because the object participates in enforced dependencies.
EXEC sp_rename 'dbo.Customers.FirstName', 'FirstNameNew', 'COLUMN';


