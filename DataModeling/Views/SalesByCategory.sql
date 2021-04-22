CREATE VIEW DataModeling.SalesByCategory AS
SELECT 
    FullDateLabel,
    Manufacturer,
    BrandName,
    ProductSubcategoryName,
    ProductCategoryName,
    SUM ( SalesQuantity ) AS SalesQuantity,
    SUM ( SalesAmount ) AS SalesAmount,
    SUM ( TotalCost ) AS TotalCost
FROM
    dbo.FactOnlineSales
    INNER JOIN dbo.DimCustomer
        ON DimCustomer.CustomerKey = FactOnlineSales.CustomerKey
    INNER JOIN dbo.DimProduct
        ON DimProduct.ProductKey = FactOnlineSales.ProductKey
    INNER JOIN dbo.DimProductSubcategory
        ON DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
    INNER JOIN dbo.DimProductCategory
        ON DimProductCategory.ProductCategoryKey = DimProductSubcategory.ProductCategoryKey
    INNER JOIN dbo.DimDate
        ON DimDate.Datekey = FactOnlineSales.DateKey
GROUP BY 
    FullDateLabel,
    Manufacturer,
    BrandName,
    ProductSubcategoryName,
    ProductCategoryName

GO

