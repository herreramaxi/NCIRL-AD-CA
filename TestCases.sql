--Test cases

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

select ca.CustomersAssociation,
		c1.FirstName + ' '  + c1.LastName as Customer1,
		c2.FirstName + ' '  + c2.LastName as Customer2,
		r.Description as RelationshipType
from dbo.vwCustomersAssociations ca
INNER JOIN dbo.Customers c1 on c1.id = ca.Customer1Id
INNER JOIN dbo.Customers c2 on c2.id = ca.Customer2Id
INNER JOIN [dbo].[ReferenceData]	r	ON	r.Id = ca.ReferenceDataId
where c1.PhoneNo =  '0878940684'

INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (10, 40, 30)
select * from  dbo.vwCustomersAssociations where CustomersAssociation = 'Paul Alcorn is Surveyor of Stanley Alan'

--Violation of PRIMARY KEY constraint 'PK_Associations'. Cannot insert duplicate key in object 'dbo.Associations'. The duplicate key value is (10, 40, 30).
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (10, 40, 30)







