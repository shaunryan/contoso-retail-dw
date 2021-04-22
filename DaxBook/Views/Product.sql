
CREATE VIEW DaxBook.[Product]
AS
SELECT  ProductKey,
        [Product Code] = ProductLabel,
        [Product Name] = ProductName,
        [Product Description] = ProductDescription,
        ProductSubcategoryKey,
        Manufacturer,
        Brand = BrandName,
        [Class] = ClassName,
        [Style] = StyleName,
        [Color] = ColorName,
        Size,
        Weight,
        [Weight Unit Measure] = NULLIF(WeightUnitMeasureID, ''),
        [Stock Type Code] = StockTypeID,
        [Stock Type] = StockTypeName,
        [Unit Cost] = UnitCost,
        [Unit Price] = UnitPrice,
        [Available Date] = AvailableForSaleDate,
        Status
FROM    [dbo].[DimProduct]

GO

