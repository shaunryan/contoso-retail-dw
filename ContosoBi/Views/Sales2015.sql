
CREATE VIEW ContosoBi.Sales2015
AS
--
--	First query, retrieves the sales of 2007..2009 reallocating it to 2013..2015.
--
--	It is intended to be copied into an Excel sheet to perform the first (disconnected) demo
--	of the book
--
SELECT
    CountryRegion,
    Brand,
    Month,
    [2007] AS [Sales2013],
    [2008] AS [Sales2014],
    [2009] AS [Sales2015]
FROM
    (SELECT
        Store.CountryRegion,
        Product.Brand,
        Date.[Calendar Year Number],
        Date.Month,
        Date.[Month Number],
        SUM(Sales.Quantity * Sales.[Unit Price]) AS SalesAmount
     FROM
        DataModeling.Sales Sales
        INNER JOIN DaxBook.Date Date
            ON Date.DateKey = Sales.OrderDateKey
        INNER JOIN DaxBook.Store Store
            ON Store.StoreKey = Sales.StoreKey
        INNER JOIN DaxBook.Product Product
            ON Product.ProductKey = Sales.ProductKey
     WHERE
        Date.DateKey <= 20091031
     GROUP BY
        Date.[Calendar Year Number],
        Date.Month,
        Date.[Month Number],
        Product.Brand,
        Store.CountryRegion
    ) Sales PIVOT ( SUM([SalesAmount]) FOR [Calendar Year Number] IN ([2007], [2008], [2009]) )
AS PivotTable;

GO

