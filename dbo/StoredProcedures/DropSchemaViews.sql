
CREATE PROCEDURE dbo.DropSchemaViews ( @schema NVARCHAR(128) )
AS
BEGIN

    DECLARE @view NVARCHAR(256)
    DECLARE @cmd NVARCHAR(500) 

    DECLARE v CURSOR
    FOR
    SELECT  name
    FROM    sys.views
    WHERE   schema_id = ( SELECT    schema_id
                          FROM      sys.schemas
                          WHERE     name = @schema
                        )
    OPEN v
    FETCH NEXT FROM v INTO @view

    WHILE @@fetch_status = 0
        BEGIN
            SET @cmd = N'DROP VIEW [' + @schema + N'].[' + @view + N']'
            EXEC ( @cmd )
            FETCH NEXT FROM v INTO @view
        END
    CLOSE v
    DEALLOCATE v

END

GO

