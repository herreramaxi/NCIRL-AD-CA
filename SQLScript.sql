USE [AD_CA_MH]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] NOT NULL,
	[AccountTypeId] [int] NOT NULL,
	[Balance] [decimal](18, 2) NULL,
	[DateOpened] [date] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Associations]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Associations](
	[Customer1Id] [int] NOT NULL,
	[Customer2Id] [int] NOT NULL,
	[ReferenceDataId] [int] NOT NULL,
 CONSTRAINT [PK_Associations] PRIMARY KEY CLUSTERED 
(
	[Customer1Id] ASC,
	[Customer2Id] ASC,
	[ReferenceDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[PhoneNo] [varchar](10) NULL,
	[AddressLine1] [varchar](50) NOT NULL,
	[City] [varchar](20) NOT NULL,
	[Country] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferenceData]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenceData](
	[Id] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ReferenceData_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Securities]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Securities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[SecurityTypeId] [int] NOT NULL,
	[Value] [decimal](18, 2) NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Securities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCustomersAssociations]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwCustomersAssociations]
 
AS
	SELECT	c1.FirstName + ' ' + c1.LastName + ' is '+ r.Description  + ' of ' + c2.FirstName + ' ' + c2.LastName AS CustomersAssociation
	FROM	[dbo].[Associations] a
			INNER JOIN [dbo].[Customers]		c1	ON	c1.Id = a.Customer1Id
			INNER JOIN [dbo].[Customers]		c2	ON	c2.Id = a.Customer2Id
			INNER JOIN [dbo].[ReferenceData]	r	ON	r.Id = a.ReferenceDataId
GO
/****** Object:  View [dbo].[vwReferenceDataDeleted]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwReferenceDataDeleted]
WITH SCHEMABINDING
AS
	SELECT  r.Id,
			r.Description
	FROM	[dbo].[ReferenceData] r
	WHERE	r.IsDeleted = 1
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (1, N'Deposit', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (2, N'Current', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (3, N'Loan', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (10, N'Personal', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (11, N'Corporate', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (20, N'Cash', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (21, N'Shares', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (22, N'Property', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (30, N'Surveyor', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (31, N'Property developer', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (32, N'Auditor', NULL)
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (33, N'Accountant', NULL)
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Customers1] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Customers1]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_ReferenceData] FOREIGN KEY([AccountTypeId])
REFERENCES [dbo].[ReferenceData] ([Id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_ReferenceData]
GO
ALTER TABLE [dbo].[Associations]  WITH CHECK ADD  CONSTRAINT [FK_Associations_ReferenceData] FOREIGN KEY([ReferenceDataId])
REFERENCES [dbo].[ReferenceData] ([Id])
GO
ALTER TABLE [dbo].[Associations] CHECK CONSTRAINT [FK_Associations_ReferenceData]
GO
ALTER TABLE [dbo].[Associations]  WITH CHECK ADD  CONSTRAINT [FK_CustomersAssociation_Customer] FOREIGN KEY([Customer1Id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Associations] CHECK CONSTRAINT [FK_CustomersAssociation_Customer]
GO
ALTER TABLE [dbo].[Associations]  WITH CHECK ADD  CONSTRAINT [FK_CustomersAssociation_Customer1] FOREIGN KEY([Customer2Id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Associations] CHECK CONSTRAINT [FK_CustomersAssociation_Customer1]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_ReferenceData] FOREIGN KEY([CustomerTypeId])
REFERENCES [dbo].[ReferenceData] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_ReferenceData]
GO
ALTER TABLE [dbo].[Securities]  WITH CHECK ADD  CONSTRAINT [FK_Securities_Accounts] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Securities] CHECK CONSTRAINT [FK_Securities_Accounts]
GO
ALTER TABLE [dbo].[Securities]  WITH CHECK ADD  CONSTRAINT [FK_Securities_ReferenceData] FOREIGN KEY([SecurityTypeId])
REFERENCES [dbo].[ReferenceData] ([Id])
GO
ALTER TABLE [dbo].[Securities] CHECK CONSTRAINT [FK_Securities_ReferenceData]
GO
/****** Object:  StoredProcedure [dbo].[CreateCustomerAndAssociation]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CreateCustomerAndAssociation]   
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
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 19/04/2021 23:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteCustomer] @CustomerId int   
AS   				
	DELETE FROM [dbo].[Associations] WHERE Customer1Id = @customerId OR Customer2Id = @customerId
	DELETE FROM [dbo].[Accounts] WHERE customerId = @customerId	
	DELETE FROM [dbo].[Customers] WHERE Id= @customerId	
GO
