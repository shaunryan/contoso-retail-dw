
CREATE VIEW ContosoBi.Date
AS
WITH    dates
          AS (SELECT DISTINCT
                DateKey = DATEADD(YEAR, 6, Datekey)
              FROM
                dbo.DimDate
              UNION ALL
              SELECT
                DateKey = DATEFROMPARTS(2012, 02, 29)
              UNION ALL
              SELECT
                DateKey = DATEFROMPARTS(2016, 02, 29)
             )
    SELECT
        DateKey = YEAR(DateKey) * 10000 + MONTH(DateKey) * 100 + DAY(DateKey),
        Date = CAST (DateKey AS DATE),
        YEAR(DateKey) AS Year,
        DATENAME(MONTH, DateKey) AS MonthName,
        MONTH(DateKey) AS MonthNumber,
        DAY(DateKey) AS DayOfMonth
    FROM
        dates;

GO

