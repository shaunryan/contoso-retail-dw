
CREATE VIEW DaxBook.[Product Subcategory]
AS
SELECT  ProductSubcategoryKey,
        [Subcategory Code] = ProductSubcategoryLabel,
        [Subcategory] = ProductSubcategoryName,
        ProductCategoryKey
FROM    dbo.DimProductSubcategory

GO

