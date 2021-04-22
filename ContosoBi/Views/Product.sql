
CREATE VIEW ContosoBi.Product
AS
SELECT
    ProductKey,
    [Product Code] = ProductLabel,
    [Product Name] = ProductName,
    dbo.DimProductCategory.ProductCategoryName AS Category,
    dbo.DimProductSubcategory.ProductSubcategoryName AS Subcategory,
    Manufacturer,
    Brand = BrandName,
    [Color] = ColorName,
    [Unit Cost] = UnitCost,
    [Unit Price] = UnitPrice
FROM
    [dbo].[DimProduct]
    LEFT OUTER JOIN dbo.DimProductSubcategory
        ON DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
    LEFT OUTER JOIN dbo.DimProductCategory
        ON DimProductCategory.ProductCategoryKey = DimProductSubcategory.ProductCategoryKey;

GO

