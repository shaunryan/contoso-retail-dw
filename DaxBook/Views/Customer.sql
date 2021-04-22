
CREATE VIEW DaxBook.[Customer]
AS
SELECT  CustomerKey,
        c.GeographyKey,
        [Customer Code] = CustomerLabel,
        Title,
        Name = COALESCE([LastName] + ', ', '') + COALESCE(FirstName, ''),
        [Birth Date] = CAST (BirthDate AS DATE),
        [Marital Status] = [MaritalStatus],
        Gender,
        [Yearly Income] = YearlyIncome,
        [Total Children] = TotalChildren,
        [Children At Home] = NumberChildrenAtHome,
        Education,
        Occupation,
        [House Ownership] = CASE HouseOwnerFlag
                              WHEN 1 THEN 'House Owner'
                              WHEN 0 THEN 'No Owner'
                            END,
        [Cars Owned] = NumberCarsOwned,
        [Continent] = g.ContinentName,
        [City] = g.CityName,
        [State] = g.StateProvinceName,
        [Country] = g.RegionCountryName,
        [Address Line 1] = AddressLine1,
        [Address Line 2] = AddressLine2,
        Phone,
        [Date First Purchase] = DateFirstPurchase,
        [Customer Type] = CustomerType,
        [Company Name] = CompanyName
FROM    dbo.DimCustomer c
LEFT JOIN dbo.DimGeography g
        ON c.GeographyKey = g.GeographyKey

GO

