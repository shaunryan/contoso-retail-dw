CREATE VIEW DataModeling.AllSalesDenormalized AS

WITH    filtered_sales
          -- Filter a sample of the rows in the table
          AS ( SELECT   *
               FROM     dbo.FactOnlineSales
               WHERE    ( SELECT    SampleRows_OnlineSales
                          FROM      DaxBook_Config.FilterRatio
                        ) IS NULL
                        OR ( OnlineSalesKey / 10 ) % 100 < ( ( SELECT  CAST (SampleRows_OnlineSales AS FLOAT) * 1000 
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
                        [Unit Price] = filtered_sales.UnitPrice
               FROM     filtered_sales
               
             )
    SELECT  
    Quantity,
	[Unit Price],
    ProductName,
    ColorName,
    Manufacturer,
	Date.Date,
    BrandName,
    ProductSubcategoryName,
    ProductCategoryName
    FROM s Purchases

    INNER JOIN dbo.DimProduct
        ON DimProduct.ProductKey = Purchases.ProductKey
    INNER JOIN dbo.DimProductSubcategory
        ON DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
    INNER JOIN dbo.DimProductCategory
        ON DimProductCategory.ProductCategoryKey = DimProductSubcategory.ProductCategoryKey
    INNER JOIN DataModeling.Date
        ON Date.Datekey = Purchases.OrderDateKey

GO

