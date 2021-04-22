CREATE VIEW ContosoBi.Sales
AS
SELECT
    StoreKey,
    ProductKey,
    CustomerKey,
    (CAST (OrderDateKey / 10000 AS INT) + 6) * 10000 + OrderDateKey % 10000 AS DateKey,
    Quantity,
    [Unit Price],
    [Unit Discount],
    [Unit Cost],
    [Net Price]
FROM
    DataModeling.Sales
WHERE
    OrderDateKey <= 20091031
    AND OrderDateKey <> 20080229;

GO

