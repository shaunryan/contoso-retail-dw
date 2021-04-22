
CREATE VIEW DaxBook.[Product Category]
AS
SELECT  ProductCategoryKey,
        [Category Code] = ProductCategoryLabel,
        Category = ProductCategoryName
FROM    dbo.DimProductCategory

GO

