CREATE TABLE [dbo].[DimStore] (
    [StoreKey]         INT               IDENTITY (1, 1) NOT NULL,
    [GeographyKey]     INT               NOT NULL,
    [StoreManager]     INT               NULL,
    [StoreType]        NVARCHAR (15)     NULL,
    [StoreName]        NVARCHAR (100)    NOT NULL,
    [StoreDescription] NVARCHAR (300)    NOT NULL,
    [Status]           NVARCHAR (20)     NOT NULL,
    [OpenDate]         DATETIME          NOT NULL,
    [CloseDate]        DATETIME          NULL,
    [EntityKey]        INT               NULL,
    [ZipCode]          NVARCHAR (20)     NULL,
    [ZipCodeExtension] NVARCHAR (10)     NULL,
    [StorePhone]       NVARCHAR (15)     NULL,
    [StoreFax]         NVARCHAR (14)     NULL,
    [AddressLine1]     NVARCHAR (100)    NULL,
    [AddressLine2]     NVARCHAR (100)    NULL,
    [CloseReason]      NVARCHAR (20)     NULL,
    [EmployeeCount]    INT               NULL,
    [SellingAreaSize]  FLOAT (53)        NULL,
    [LastRemodelDate]  DATETIME          NULL,
    [GeoLocation]      [sys].[geography] NULL,
    [Geometry]         [sys].[geometry]  NULL,
    [ETLLoadID]        INT               NULL,
    [LoadDate]         DATETIME          NULL,
    [UpdateDate]       DATETIME          NULL,
    CONSTRAINT [PK_DimStore_StoreKey] PRIMARY KEY CLUSTERED ([StoreKey] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [FK_DimStore_DimGeography] FOREIGN KEY ([GeographyKey]) REFERENCES [dbo].[DimGeography] ([GeographyKey])
);


GO

