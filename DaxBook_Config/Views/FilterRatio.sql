

-- For each filter use NULL to disable sampling, otherwise put the number of rows to get as a sample
CREATE VIEW [DaxBook_Config].[FilterRatio]
AS
SELECT  SampleRows_OnlineSales    = 100000,
        SampleRows_StoreSales     = 100000,
		SampleRows_InventorySales = 100000
        -- WHERE 1 = 0 -- Use this WHERE condition to show all the values (around 10M rows)

GO

