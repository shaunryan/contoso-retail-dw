
CREATE PROCEDURE dbo.DropSchema ( @schema NVARCHAR(128) )
AS
BEGIN

    DECLARE @view NVARCHAR(256)
    DECLARE @cmd NVARCHAR(500) 

    EXEC DropSchemaViews @schema 

    IF EXISTS ( SELECT  schema_id
                FROM    sys.schemas
                WHERE   name = @schema )
        BEGIN
            SET @cmd = N'DROP SCHEMA [' + @schema + N']'
            EXEC ( @cmd )
        END
    
END

GO

