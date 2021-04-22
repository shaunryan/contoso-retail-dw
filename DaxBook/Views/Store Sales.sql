
CREATE VIEW DaxBook.[Store Sales]
AS
WITH    filtered_sales
          -- Filter a sample of the rows in the table
          AS ( SELECT   *
               FROM     dbo.FactSales
               WHERE    ( SELECT    SampleRows_StoreSales
                          FROM      DaxBook_Config.FilterRatio
                        ) IS NULL
                        OR ( SalesKey / 10 ) % 1000 < ( ( SELECT    CAST (SampleRows_StoreSales AS FLOAT) * 1000
                                                          FROM      DaxBook_Config.FilterRatio
                                                        ) / ( SELECT COUNT (1) FROM dbo.FactSales
                                                            ) )
             ),
        s AS ( SELECT   SalesKey,
                        channelKey,
                        StoreKey,
                        ProductKey,
                        PromotionKey,
                        CurrencyKey,
                        [Date] = CAST (DateKey AS DATE),
                        [DateKey] = YEAR(DateKey) * 10000 + MONTH(DateKey) * 100 + DAY(DateKey),
                        [Quantity] = SalesQuantity,
                        [Unit Price] = UnitPrice,
                        [Unit Cost] = UnitCost,
                        [Discount Quantity] = DiscountQuantity,
                        [Discount Amount] = DiscountAmount
               FROM     filtered_sales
             )
    SELECT  s.SalesKey,
            s.ChannelKey,
            s.StoreKey,
            s.ProductKey,
            s.PromotionKey,
            s.CurrencyKey,
            s.[Date],
            s.Quantity,
            s.[Unit Price],
            s.[Unit Cost],
            s.[Discount Quantity],
            s.[Discount Amount]
       -- Total line values are not included in the view - should be calculated in DAX measures
       --[Sales Amount] = s.Quantity * s.[Unit Price] - s.[Discount Amount,
       --[Total Cost] = s.Quantity * s.[Unit Cost]
    FROM    s

GO

