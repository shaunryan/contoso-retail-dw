

CREATE VIEW DaxBook.[Currency]
AS
SELECT CurrencyKey,
       [Currency Code] = CurrencyName,
       [Currency] = CurrencyDescription
FROM dbo.DimCurrency

GO

