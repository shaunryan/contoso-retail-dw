
CREATE VIEW ContosoBi.Store
AS
SELECT
    StoreKey,
    [Store Manager] = s.StoreManager,
    [Store Type] = StoreType,
    [Store Name] = StoreName,
    [Continent] = g.ContinentName,
    [City] = g.CityName,
    [State] = g.StateProvinceName,
    [CountryRegion] = g.RegionCountryName,
    [Employees] = EmployeeCount,
    [Selling Area] = SellingAreaSize
FROM
    dbo.DimStore s
    LEFT JOIN dbo.DimGeography g
        ON s.GeographyKey = g.GeographyKey;

GO

