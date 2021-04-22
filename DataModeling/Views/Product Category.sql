
CREATE VIEW DataModeling.[Product Category]
AS
SELECT  ProductCategoryKey,
        [Category Code] = ProductCategoryLabel,
        Category = ProductCategoryName
FROM    dbo.DimProductCategory

GO

