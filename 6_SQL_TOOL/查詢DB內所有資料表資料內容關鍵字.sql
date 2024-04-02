DECLARE @SearchKeyword NVARCHAR(100)
SET @SearchKeyword = 'F001'

DECLARE @TableName NVARCHAR(100)
DECLARE @ColumnName NVARCHAR(100)
DECLARE @SearchQuery NVARCHAR(MAX)

CREATE TABLE #SearchResults (
    TableName NVARCHAR(100),
    ColumnName NVARCHAR(100),
    ColumnValue NVARCHAR(MAX)
)

DECLARE TableCursor CURSOR FOR

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
--and TABLE_NAME = 't_carrier'

OPEN TableCursor

FETCH NEXT FROM TableCursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE ColumnCursor CURSOR FOR
    SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName

    OPEN ColumnCursor

    FETCH NEXT FROM ColumnCursor INTO @ColumnName

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SearchQuery = 'INSERT INTO #SearchResults SELECT ''' + @TableName + ''', ''' + @ColumnName + ''', CAST(' + @ColumnName + ' AS NVARCHAR(MAX)) FROM ' + @TableName + ' WHERE ' + @ColumnName + ' LIKE ''%' + @SearchKeyword + '%'''
        EXEC (@SearchQuery)

        FETCH NEXT FROM ColumnCursor INTO @ColumnName
    END

    CLOSE ColumnCursor
    DEALLOCATE ColumnCursor

    FETCH NEXT FROM TableCursor INTO @TableName
END

CLOSE TableCursor
DEALLOCATE TableCursor

SELECT *
FROM #SearchResults

DROP TABLE #SearchResults
