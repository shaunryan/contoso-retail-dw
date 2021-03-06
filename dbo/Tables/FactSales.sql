CREATE TABLE [dbo].[FactSales] (
    [SalesKey]         INT      IDENTITY (1, 1) NOT NULL,
    [DateKey]          DATETIME NOT NULL,
    [channelKey]       INT      NOT NULL,
    [StoreKey]         INT      NOT NULL,
    [ProductKey]       INT      NOT NULL,
    [PromotionKey]     INT      NOT NULL,
    [CurrencyKey]      INT      NOT NULL,
    [UnitCost]         MONEY    NOT NULL,
    [UnitPrice]        MONEY    NOT NULL,
    [SalesQuantity]    INT      NOT NULL,
    [ReturnQuantity]   INT      NOT NULL,
    [ReturnAmount]     MONEY    NULL,
    [DiscountQuantity] INT      NULL,
    [DiscountAmount]   MONEY    NULL,
    [TotalCost]        MONEY    NOT NULL,
    [SalesAmount]      MONEY    NOT NULL,
    [ETLLoadID]        INT      NULL,
    [LoadDate]         DATETIME NULL,
    [UpdateDate]       DATETIME NULL,
    CONSTRAINT [PK_FactSales_SalesKey] PRIMARY KEY CLUSTERED ([SalesKey] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [FK_FactSales_DimChannel] FOREIGN KEY ([channelKey]) REFERENCES [dbo].[DimChannel] ([ChannelKey]),
    CONSTRAINT [FK_FactSales_DimCurrency] FOREIGN KEY ([CurrencyKey]) REFERENCES [dbo].[DimCurrency] ([CurrencyKey]),
    CONSTRAINT [FK_FactSales_DimDate] FOREIGN KEY ([DateKey]) REFERENCES [dbo].[DimDate] ([Datekey]),
    CONSTRAINT [FK_FactSales_DimProduct] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct] ([ProductKey]),
    CONSTRAINT [FK_FactSales_DimPromotion] FOREIGN KEY ([PromotionKey]) REFERENCES [dbo].[DimPromotion] ([PromotionKey]),
    CONSTRAINT [FK_FactSales_DimStore] FOREIGN KEY ([StoreKey]) REFERENCES [dbo].[DimStore] ([StoreKey])
);


GO

