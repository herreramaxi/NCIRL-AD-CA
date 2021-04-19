USE [AD_CA_MH]
GO


delete from [dbo].[accounts]
delete from [dbo].[Associations]
delete from [dbo].[customers]
delete from [dbo].ReferenceData

--Account Type
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (1,'Deposit')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (2,'Current')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (3,'Loan')

--Customer Type
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (10,'Personal')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (11,'Corporate')

--Security Type
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (20,'Cash')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (21,'Shares')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (22,'Property')

--Association Type
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (30,'Surveyor')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (31,'Property developer')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (32,'Auditor')
INSERT INTO [dbo].[ReferenceData] ([Id],[Description]) VALUES (33,'Accountant')

SET IDENTITY_INSERT [dbo].[Customers] ON
INSERT INTO [dbo].[Customers]([Id],[CustomerTypeId],[FirstName],[LastName],[PhoneNo], [AddressLine1], [City], [Country]) VALUES (1,1,'FirstName1', 'LastName1','phoneNo1','AddressLine1','Dublin1','Ireland')
INSERT INTO [dbo].[Customers]([Id],[CustomerTypeId],[FirstName],[LastName],[PhoneNo], [AddressLine1], [City], [Country]) VALUES (2,1,'FirstName2', 'LastName2','phoneNo2','AddressLine2','Dublin1','Ireland')
INSERT INTO [dbo].[Customers]([Id],[CustomerTypeId],[FirstName],[LastName],[PhoneNo], [AddressLine1], [City], [Country]) VALUES (3,1,'FirstName3', 'LastName3','phoneNo3','AddressLine3','Dublin1','Ireland')
SET IDENTITY_INSERT [dbo].[Customers] OFF

SET IDENTITY_INSERT [dbo].[Accounts] ON
INSERT INTO [dbo].[Accounts] ([Id],[AccountTypeId],[Balance],[DateOpened],[CustomerId])  VALUES(1,1,1000,'2020-01-10',1)
INSERT INTO [dbo].[Accounts] ([Id],[AccountTypeId],[Balance],[DateOpened],[CustomerId])  VALUES(2,2,500000,'2020-01-10',2)
INSERT INTO [dbo].[Accounts] ([Id],[AccountTypeId],[Balance],[DateOpened],[CustomerId])  VALUES(3,3,200000,'2020-01-10',3)
SET IDENTITY_INSERT [dbo].[Accounts] OFF


