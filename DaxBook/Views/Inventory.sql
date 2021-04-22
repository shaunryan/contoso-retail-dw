

CREATE VIEW DaxBook.[Inventory]
AS
WITH    filtered_inventory
          -- Filter a sample of the rows in the table
          AS ( SELECT   *
               FROM     dbo.FactInventory
               WHERE    ( SELECT    SampleRows_InventorySales
                          FROM      DaxBook_Config.FilterRatio
                        ) IS NULL
                        OR ( InventoryKey / 10 ) % 1000 < ( ( SELECT    CAST (SampleRows_InventorySales AS FLOAT) * 1000 
                                                          FROM      DaxBook_Config.FilterRatio
                                                        ) / ( SELECT COUNT (1) FROM dbo.FactInventory
                                                            ) )
             ),
        i AS ( SELECT   InventoryKey,
                        StoreKey,
                        ProductKey,
                        CurrencyKey,
                        [Date] = CAST (DateKey AS DATE),
                        [DateKey] = YEAR(DateKey) * 10000 + MONTH(DateKey) * 100 + DAY(DateKey),
                        [Quantity] = OnHandQuantity,
                        [Unit Cost] = UnitCost
               FROM     filtered_inventory
             )
    SELECT  i.InventoryKey,
            i.StoreKey,
            i.ProductKey,
            i.CurrencyKey,
            i.[Date],
            i.Quantity,
            i.[Unit Cost]
       -- Total line values are not included in the view - should be calculated in DAX measures
       --[Total Cost] = i.Quantity * i.[Unit Cost]
    FROM    i

GO

