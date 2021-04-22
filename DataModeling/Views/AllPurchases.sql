CREATE VIEW DataModeling.AllPurchases AS

WITH    filtered_sales
          -- Filter a sample of the rows in the table
          AS ( SELECT   *
               FROM     dbo.FactSales
               WHERE    ( SELECT    SampleRows_OnlineSales
                          FROM      DaxBook_Config.FilterRatio
                        ) IS NULL
                        OR ( SalesKey / 10 ) % 100 < ( ( SELECT  CAST (SampleRows_OnlineSales AS FLOAT) * 1000 
                                                                FROM    DaxBook_Config.FilterRatio
                                                              ) / ( SELECT COUNT (1) FROM dbo.FactOnlineSales
                                                                  ) )
             ),
        s AS ( SELECT   StoreKey,
                        ProductKey,
                        PromotionKey,
                        CurrencyKey,
                        [OrderDateKey] = YEAR(DateKey) * 10000 + MONTH(DateKey) * 100 + DAY(DateKey),
        -- Increase quantity to 20% of sales transactions
                        [Quantity] = SalesQuantity,
                        [Unit Cost] = UnitCost
               FROM     filtered_sales
               
             )
    SELECT  
    Quantity,
	[Unit cost],
    ProductKey,
	OrderDateKey
    FROM s Purchases

GO

