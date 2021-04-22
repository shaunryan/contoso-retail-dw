CREATE VIEW DaxBook.Employee
AS
SELECT [EmployeeKey]
      ,[ParentEmployeeKey]
      ,[FirstName] + ' ' + [LastName] AS Name
  FROM [ContosoRetailDW].[dbo].[DimEmployee]

GO

