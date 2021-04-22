
CREATE VIEW DataModeling.[Store]
AS
SELECT  StoreKey,
        s.GeographyKey,
        [Store Manager] = s.StoreManager,
        [Store Type] = StoreType,
        [Store Name] = StoreName,
        Status,
        [Open Date] = OpenDate,
        [Close Date] = CloseDate,
        [Zip Code] = ZipCode,
        [Zip Code Extension] = ZipCodeExtension,
        [Store Phone] = StorePhone,
        StoreFax,
        [Continent] = g.ContinentName,
        [City] = g.CityName,
        [State] = g.StateProvinceName,
        [CountryRegion] = g.RegionCountryName,
        [Address Line 1] = AddressLine1,
        [Address Line 2] = AddressLine2,
        [Close Reason] = CloseReason,
        [Employees] = EmployeeCount,
        [Selling Area] = SellingAreaSize,
        [Last Remodel Date] = LastRemodelDate
FROM    dbo.DimStore s
LEFT JOIN dbo.DimGeography g
        ON s.GeographyKey = g.GeographyKey
--WHERE   s.ZipCode <> s.ZipCodeExtension

GO

