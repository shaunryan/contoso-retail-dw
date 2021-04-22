

CREATE VIEW DaxBook.[Channel]
AS
SELECT ChannelKey,
       [Channel Code] = ChannelLabel,
       [Channel] = ChannelName
FROM dbo.DimChannel

GO

