USE [master]
GO
/****** Object:  Database [AD_CA_MH]    Script Date: 24/04/2021 15:33:38 ******/
CREATE DATABASE [AD_CA_MH]
GO
ALTER DATABASE [AD_CA_MH] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AD_CA_MH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AD_CA_MH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AD_CA_MH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AD_CA_MH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AD_CA_MH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AD_CA_MH] SET ARITHABORT OFF 
GO
ALTER DATABASE [AD_CA_MH] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AD_CA_MH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AD_CA_MH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AD_CA_MH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AD_CA_MH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AD_CA_MH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AD_CA_MH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AD_CA_MH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AD_CA_MH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AD_CA_MH] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AD_CA_MH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AD_CA_MH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AD_CA_MH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AD_CA_MH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AD_CA_MH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AD_CA_MH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AD_CA_MH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AD_CA_MH] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AD_CA_MH] SET  MULTI_USER 
GO
ALTER DATABASE [AD_CA_MH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AD_CA_MH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AD_CA_MH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AD_CA_MH] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AD_CA_MH] SET DELAYED_DURABILITY = DISABLED 
GO
USE [AD_CA_MH]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 24/04/2021 15:33:38 ******/
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
/****** Object:  Table [dbo].[Associations]    Script Date: 24/04/2021 15:33:38 ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 24/04/2021 15:33:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[PhoneNo] [varchar](25) NOT NULL,
	[AddressLine1] [varchar](60) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[Country] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferenceData]    Script Date: 24/04/2021 15:33:38 ******/
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
/****** Object:  Table [dbo].[Securities]    Script Date: 24/04/2021 15:33:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Securities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[SecurityTypeId] [int] NOT NULL,
	[Value] [decimal](18, 2) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Code] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Securities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCustomersAssociations]    Script Date: 24/04/2021 15:33:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCustomersAssociations]
WITH SCHEMABINDING
AS	
	SELECT	c1.FirstName + ' ' + c1.LastName + ' is '+ r.Description  + ' of ' + c2.FirstName + ' ' + c2.LastName AS CustomersAssociation,
			c1.FirstName + ' '  + c1.LastName AS Customer1,		
			c2.FirstName + ' '  + c2.LastName AS Customer2,
			r.Description AS RelationshipType,
			a.Customer1Id AS Customer1Id,
			a.Customer2Id AS Customer2Id,
			a.ReferenceDataId
	FROM	[dbo].[Associations] a
			INNER JOIN [dbo].[Customers]		c1	ON	c1.Id = a.Customer1Id
			INNER JOIN [dbo].[Customers]		c2	ON	c2.Id = a.Customer2Id
			INNER JOIN [dbo].[ReferenceData]	r	ON	r.Id = a.ReferenceDataId
GO
/****** Object:  View [dbo].[vwReferenceDataDeleted]    Script Date: 24/04/2021 15:33:38 ******/
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
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (1, 1, CAST(20000.00 AS Decimal(18, 2)), CAST(N'2000-01-18' AS Date), 30)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (2, 2, CAST(30000.00 AS Decimal(18, 2)), CAST(N'2010-02-19' AS Date), 30)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (3, 3, CAST(45000.00 AS Decimal(18, 2)), CAST(N'2011-02-19' AS Date), 30)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (4, 4, CAST(15000.00 AS Decimal(18, 2)), CAST(N'2000-01-18' AS Date), 31)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (5, 5, CAST(30000.00 AS Decimal(18, 2)), CAST(N'2010-02-19' AS Date), 31)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (6, 6, CAST(50000.00 AS Decimal(18, 2)), CAST(N'2011-02-19' AS Date), 31)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (7, 7, CAST(15000.00 AS Decimal(18, 2)), CAST(N'2005-01-24' AS Date), 32)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (8, 8, CAST(30000.00 AS Decimal(18, 2)), CAST(N'2007-03-23' AS Date), 32)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (9, 9, CAST(50000.00 AS Decimal(18, 2)), CAST(N'2008-04-01' AS Date), 32)
GO
INSERT [dbo].[Accounts] ([Id], [AccountTypeId], [Balance], [DateOpened], [CustomerId]) VALUES (10, 10, CAST(150000.00 AS Decimal(18, 2)), CAST(N'2019-06-01' AS Date), 32)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (1, 10, 30)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (1, 10, 31)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (1, 10, 32)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (2, 11, 33)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (2, 11, 34)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (2, 11, 35)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (3, 12, 36)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (3, 12, 37)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (3, 12, 38)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (3, 12, 39)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (30, 32, 31)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (32, 31, 30)
GO
INSERT [dbo].[Associations] ([Customer1Id], [Customer2Id], [ReferenceDataId]) VALUES (32, 33, 31)
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (1, 21, N'Catherine', N'Abel', N'747-555-0171', N'57251 Serene Blvd', N'Van Nuys', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (2, 20, N'Kim', N'Abercrombie', N'334-555-0137', N'Tanger Factory', N'Branch', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (3, 21, N'Frances', N'Adams', N'991-555-0183', N'6900 Sisk Road', N'Modesto', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (4, 20, N'Margaret', N'Smith', N'959-555-0151', N'Lewiston Mall', N'Lewiston', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (5, 20, N'Jay', N'Adams', N'158-555-0142', N'Blue Ridge Mall', N'Kansas City', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (6, 20, N'Samuel', N'Agcaoili', N'554-555-0120', N'No. 25800-130 King Street West', N'Toronto', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (7, 20, N'Robert', N'Ahlering', N'678-555-0175', N'6500 East Grant Road', N'Tucson', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (8, 21, N'François', N'Ferrier', N'571-555-0128', N'Eastridge Mall', N'Casper', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (9, 21, N'Amy', N'Alberts', N'727-555-0215', N'252851 Rowan Place', N'Richmond', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (10, 20, N'Paul', N'Alcorn', N'331-555-0162', N'White Mountain Mall', N'Rock Springs', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (11, 21, N'Gregory', N'Alderson', N'968-555-0153', N'26920 Indela Road', N'Montreal', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (12, 21, N'Gregory', N'Alderson', N'968-555-0153', N'25981 College Street', N'Montreal', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (13, 21, N'Michelle', N'Alexander', N'215-555-0175', N'22589 West Craig Road', N'North Las Vegas', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (14, 20, N'Sean', N'Jacobson', N'555-555-0162', N'2551 East Warner Road', N'Gilbert', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (15, 20, N'Marvin', N'Allen', N'447-555-0120', N'First Colony Mall', N'Sugar Land', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (16, 20, N'Cecil', N'Allison', N'699-555-0155', N'254 Colonnade Road', N'Nepean', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (17, 21, N'Oscar', N'Alpuerto', N'855-555-0174', N'Rocky Mountain Pines Outlet', N'Loveland', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (18, 21, N'Maxwell', N'Amland', N'614-555-0134', N'Suite 99320 255 - 520th Avenue S.W.', N'Calgary', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (19, 21, N'Ramona', N'Antrim', N'327-555-0148', N'998 Forest Road', N'Saginaw', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (20, 21, N'Tom', N'Johnston', N'883-555-0177', N'Belz Factory Outlet', N'Las Vegas', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (21, 20, N'Thomas', N'Armstrong', N'226-555-0146', N'Fox Hills', N'Culver City', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (22, 21, N'John', N'Arthur', N'149-555-0213', N'2345 North Freeway', N'Houston', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (23, 20, N'Chris', N'Ashton', N'556-555-0145', N'70 N.W. Plaza', N'Saint Ann', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (24, 21, N'Teresa', N'Atkinson', N'129-555-0120', N'The Citadel Commerce Plaza', N'City Of Commerce', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (25, 21, N'Robert', N'Avalos', N'665-555-0198', N'700 Bureau Road', N'Montreal', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (26, 20, N'Stephen', N'Ayers', N'818-555-0171', N'2533 Eureka Rd.', N'Southgate', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (27, 20, N'Daniel', N'Blanco', N'221-555-0167', N'Suite 800 2530 Slater Street', N'Ottawa', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (28, 21, N'Cory', N'Booth', N'121-555-0157', N'Eastern Beltway Center', N'Las Vegas', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (29, 20, N'James', N'Bailey', N'234-555-0212', N'Southgate Mall', N'Missoula', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (30, 21, N'Douglas', N'Baldwin', N'583-555-0130', N'Horizon Outlet Center', N'Holland', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (31, 21, N'Wayne', N'Banack', N'640-555-0189', N'48255 I-20 E. @ Eastpoint Blvd.', N'Baytown', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (32, 20, N'Robert', N'Barker', N'241-555-0212', N'6789 Warren Road', N'Westland', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (33, 21, N'Josh', N'Barnhill', N'584-555-0192', N'25 First Canadian Place', N'Toronto', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (34, 21, N'Gytis', N'Barzdukas', N'257-555-0219', N'25900-700-9th Ave S.W.', N'Calgary', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (35, 20, N'Shaun', N'Beasley', N'396-555-0187', N'2500-622 5th Ave Sw', N'Calgary', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (36, 21, N'John', N'Beaver', N'521-555-0195', N'1318 Lasalle Street', N'Bothell', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (37, 21, N'John', N'Beaver', N'521-555-0195', N'99300 223rd Southeast', N'Bothell', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (38, 20, N'Christopher', N'Beck', N'1 (21) 500 555-0132', N'93-2501, Blackfriars Road,', N'London', N'United Kingdom')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (39, 20, N'Ann', N'Beebe', N'277-555-0169', N'25537 Hillside Avenue', N'Victoria', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (40, 20, N'Stanley', N'Alan', N'156-555-0126', N'567 Sw Mcloughlin Blvd', N'Milwaukie', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (41, 21, N'Edna', N'Benson', N'789-555-0189', N'Po Box 8035996', N'Dallas', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (42, 20, N'Payton', N'Benson', N'528-555-0183', N'997000 Telegraph Rd.', N'Southfield', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (43, 21, N'Alexander', N'Berger', N'519-555-0151', N'253721 Mayfield Place, Unit 150', N'Richmond', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (44, 20, N'John', N'Berger', N'156-555-0211', N'5700 Explorer Drive', N'Mississauga', N'Canada')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (45, 21, N'Robert', N'Bernacchi', N'449-555-0176', N'2681 Eagle Peak', N'Bellevue', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (46, 21, N'Robert', N'Bernacchi', N'449-555-0176', N'25915 140th Ave Ne', N'Bellevue', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (47, 20, N'Matthias', N'Berndt', N'384-555-0169', N'Escondido', N'Escondido', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (48, 20, N'Steven', N'Brown', N'280-555-0124', N'5500 Grossmont Center Drive', N'La Mesa', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (49, 21, N'Jimmy', N'Bischoff', N'992-555-0211', N'3065 Santa Margarita Parkway', N'Trabuco Canyon', N'United States')
GO
INSERT [dbo].[Customers] ([Id], [CustomerTypeId], [FirstName], [LastName], [PhoneNo], [AddressLine1], [City], [Country]) VALUES (50, 20, N'Mae', N'Black', N'264-555-0143', N'Redford Plaza', N'Redford', N'United States')
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (1, N'Deposit', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (2, N'Current', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (3, N'Loan', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (4, N'Cash', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (5, N'Saving', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (6, N'Demand', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (7, N'Notice', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (8, N'Fixed-term', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (9, N'Guaranteed bonds', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (10, N'Basic', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (20, N'Personal', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (21, N'Corporate', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (30, N'Surveyor', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (31, N'Property developer', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (32, N'Auditor', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (33, N'Accountant', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (34, N'Consultant', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (35, N'Solicitor', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (36, N'Auctioneer', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (37, N'State agent', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (38, N'Financial accountant', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (39, N'Payroll administrator', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (50, N'Cash', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (51, N'Shares', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (52, N'Property', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (53, N'Stocks', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (54, N'Bonds', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (55, N'Preferred Shares', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (56, N'Exchange-Traded Funds', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (57, N'Futures', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (58, N'Options', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (59, N'Hedge funds', NULL)
GO
INSERT [dbo].[ReferenceData] ([Id], [Description], [IsDeleted]) VALUES (60, N'Stock rights and warrants', NULL)
GO
SET IDENTITY_INSERT [dbo].[Securities] ON 
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (1, 1, 53, CAST(100000.00 AS Decimal(18, 2)), N'MercadoLibre', N'MELI')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (2, 1, 53, CAST(200000.00 AS Decimal(18, 2)), N'MasterCard', N'MA')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (3, 2, 53, CAST(300000.00 AS Decimal(18, 2)), N'Bitcoin', N'BTCUSD')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (4, 3, 53, CAST(400000.00 AS Decimal(18, 2)), N'Gold', N'XAU')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (5, 4, 53, CAST(100000.00 AS Decimal(18, 2)), N'Oil', N'CL')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (6, 5, 53, CAST(200000.00 AS Decimal(18, 2)), N'Facebook', N'FB')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (7, 6, 53, CAST(300000.00 AS Decimal(18, 2)), N'Microsoft', N'MSFT')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (8, 6, 59, CAST(400000.00 AS Decimal(18, 2)), N'Amazon.com', N'AMZN')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (9, 7, 59, CAST(100000.00 AS Decimal(18, 2)), N'Alphabet', N'GOOG')
GO
INSERT [dbo].[Securities] ([Id], [AccountId], [SecurityTypeId], [Value], [Name], [Code]) VALUES (10, 7, 59, CAST(200000.00 AS Decimal(18, 2)), N'American Express', N'AXP')
GO
SET IDENTITY_INSERT [dbo].[Securities] OFF
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_Country]  DEFAULT ('Ireland') FOR [Country]
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
/****** Object:  StoredProcedure [dbo].[CreateCustomerAndAssociation]    Script Date: 24/04/2021 15:33:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateCustomerAndAssociation]   
	@FirstName nvarchar(50),
    @LastName nvarchar(50), 
	@AddressLine1 nvarchar(60),
	@City nvarchar(30),
	@Country nvarchar(50),
	@PhoneNo nvarchar(25),
	@CustomerTypeId int,
	@CustomerId2 int,
	@AssociationTypeId int
AS   
	BEGIN TRANSACTION T1
	INSERT INTO [dbo].[Customers]([CustomerTypeId],[FirstName],[LastName],[PhoneNo],[AddressLine1],[City],[Country]) 
	VALUES (@CustomerTypeId,@FirstName, @LastName,@PhoneNo,@AddressLine1, @City, @Country)

	DECLARE @customerId AS INT = @@IDENTITY 
	
	INSERT INTO [dbo].[Associations] ([Customer1Id],[Customer2Id],[ReferenceDataId]) VALUES (@customerId, @CustomerId2, @AssociationTypeId)
	
	COMMIT TRANSACTION T1

GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 24/04/2021 15:33:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteCustomer] @CustomerId int   
AS   	
	BEGIN TRANSACTION T1			
	
	DELETE FROM [dbo].[Associations] WHERE Customer1Id = @customerId OR Customer2Id = @customerId
	DELETE FROM [dbo].[Securities] WHERE AccountId IN (SELECT Id FROM [dbo].[Accounts] WHERE customerId = @customerId)
	DELETE FROM [dbo].[Accounts] WHERE customerId = @customerId	
	DELETE FROM [dbo].[Customers] WHERE Id= @customerId	
	
	COMMIT TRANSACTION T1
GO
USE [master]
GO
ALTER DATABASE [AD_CA_MH] SET  READ_WRITE 
GO
