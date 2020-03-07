CREATE TABLE [dbo].[Airports](
	[IATACODE] [varchar](5) NULL,
	[AIRPORT] [varchar](5) NULL,
	[CITY] [varchar](5) NULL,
	[STATE] [varchar](5) NULL,
	[COUNTRY] [varchar](5) NULL,
	[LATITUDE] [numeric](8, 4) NULL,
	[LONGITUDE] [decimal](8, 4) NULL
) ON [PRIMARY]
GO