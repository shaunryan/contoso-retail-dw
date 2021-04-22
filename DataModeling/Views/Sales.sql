
CREATE VIEW DataModeling.[Sales]
AS
WITH    filtered_sales
          -- Filter a sample of the rows in the table
          AS ( SELECT   *
               FROM     dbo.FactOnlineSales
               WHERE    ( SELECT    SampleRows_OnlineSales
                          FROM      DaxBook_Config.FilterRatio
                        ) IS NULL
                        OR ( OnlineSalesKey / 10 ) % 1000 < ( ( SELECT  CAST (SampleRows_OnlineSales AS FLOAT) * 1000 
                                                                FROM    DaxBook_Config.FilterRatio
                                                              ) / ( SELECT COUNT (1) FROM dbo.FactOnlineSales
                                                                  ) )
             ),
        s AS ( SELECT   OnlineSalesKey,
                        StoreKey,
                        ProductKey,
                        PromotionKey,
                        CurrencyKey,
                        CustomerKey,
                        [Order Date] = CAST (DateKey AS DATE),
                        [Due Date] = CAST (DateKey + ( ProductKey + OnlineSalesKey + CustomerKey ) % 8 + 6 AS DATE),
                        -- Delivery improves over time
                        [Delivery Date] = CAST (DateKey + ( StoreKey + ProductKey + OnlineSalesKey + CustomerKey )
                        % ( 2014 - YEAR(DateKey) ) + 6 AS DATE),
                        [Order Number] = SalesOrderNumber,
                        [Order Line Number] = SalesOrderLineNumber,
        -- Increase quantity to 20% of sales transactions
                        [Quantity] = SalesQuantity
                        * CASE WHEN SalesQuantity = 1
                                    AND ( ProductKey + OnlineSalesKey + CustomerKey ) % 5 = 0
                               THEN ( ProductKey + StoreKey + ( OnlineSalesKey * 4 ) + CustomerKey ) % 3 + 2
                               ELSE SalesQuantity
                          END,
                        [Unit Price] = UnitPrice,
                        [Unit Discount] = DiscountAmount,
                        [Unit Cost] = UnitCost,
                        [Net Price] = UnitPrice - DiscountAmount
               FROM     filtered_sales
               WHERE    SalesQuantity = 1 -- Ignore Returned items
             )
    SELECT  
            s.StoreKey,
            s.ProductKey,
            s.PromotionKey,
            s.CurrencyKey,
            s.CustomerKey,
            [OrderDateKey] = YEAR(s.[Order Date]) * 10000 + MONTH(s.[Order Date]) * 100 + DAY(s.[Order Date]),
            [DueDateKey] = YEAR(s.[Due Date]) * 10000 + MONTH(s.[Due Date]) * 100 + DAY(s.[Due Date]),
            [DeliveryDateKey] = YEAR(s.[Delivery Date]) * 10000 + MONTH(s.[Delivery Date]) * 100 + DAY(s.[Delivery Date]),
            s.[Order Date],
            s.[Due Date],
            s.[Delivery Date],
            s.[Order Number],
            s.[Order Line Number],
            s.Quantity,
            s.[Unit Price],
            s.[Unit Discount],
            s.[Unit Cost],
            s.[Net Price]
    FROM    s

GO

