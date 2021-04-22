CREATE VIEW DataModeling.[Promotion]
AS
SELECT PromotionKey,
       [Promotion Code] = PromotionLabel,
       Promotion = PromotionName,
       Discount = DiscountPercent,
       [Promotion Type] = PromotionType,
       [Promotion Category] = PromotionCategory,
       [Start Date] = StartDate,
       [End Date] = EndDate
FROM dbo.DimPromotion

GO

