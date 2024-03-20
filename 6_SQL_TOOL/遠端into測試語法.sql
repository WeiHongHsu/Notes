DECLARE @DB_name SYSNAME
SET @DB_name = ( SELECT DB_NAME() )
DECLARE @Schema SYSNAME
SET @Schema = 'dbo'
DECLARE @Table SYSNAME
SET @Table = 'w_POD'
DECLARE @Date_column SYSNAME
SET @Date_column = 'Adddate'
DECLARE @Keepdays INT
SET @Keepdays = 300
DECLARE @Maxrows INT
SET @Maxrows = 10

DECLARE @MSG VARCHAR(200)
DECLARE @SQLString NVARCHAR(MAX)
DECLARE @ParmDefinition NVARCHAR(500)
DECLARE @CountRows TABLE (CountRows INT)
DECLARE @CountRows_Count INT

DECLARE @DB_LINK SYSNAME
SET @DB_LINK = 'HJWMS_TEST'
DECLARE @DB_name_dest SYSNAME
SET @DB_name_dest = @DB_name + '_A'


SET @SQLString = ' 
SELECT *  FROM HJWMS_TEST.IEXP_A.INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = ''dbo'' AND TABLE_NAME = ''w_POD'''

select top 10 * [HJWMS_TEST].IEXP_A.dbo.w_POD into  from  w_POD 

EXECUTE sp_executesql @SQLString


SELECT *  FROM HJWMS_TEST.IEXP_A.INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'w_POD'


SET @SQLString = ' 
IF EXISTS ( SELECT *  FROM ' + QUOTENAME(@DB_LINK) + '.' + QUOTENAME(@DB_name_dest) +  '.' + 'INFORMATION_SCHEMA.TABLES
                  WHERE TABLE_SCHEMA = ''' + QUOTENAME(@Schema) + ''' AND TABLE_NAME = ''' + QUOTENAME(@Table) + ''' )
BEGIN
       ;WITH CTE AS
       ( 
	   SELECT TOP ( @Maxrows_IN ) * FROM ' + QUOTENAME(@DB_name) + '.' + QUOTENAME(@Schema) + '.' + QUOTENAME(@Table)    
       + ' WHERE ABS(DATEDIFF(Day,GETDATE(),' + @Date_column + ')) > ABS(ISNULL(TRY_CONVERT(INT,@Keepdays_IN),99999))
       ORDER BY ' + @Date_column + '
       )
       INSERT INTO  ' + QUOTENAME(@DB_LINK) + '.' + QUOTENAME(@DB_name_dest) + '.' + QUOTENAME(@Schema) + '.' + QUOTENAME(@Table) +'
       SELECT * FROM CTE
END
ELSE
BEGIN
       ;WITH CTE AS
       ( SELECT TOP ( @Maxrows_IN ) * FROM ' + QUOTENAME(@DB_name) + '.' + QUOTENAME(@Schema) + '.' + QUOTENAME(@Table)    
       + ' WHERE ABS(DATEDIFF(Day,GETDATE(),' + @Date_column + ')) > ABS(ISNULL(TRY_CONVERT(INT,@Keepdays_IN),99999))
       ORDER BY ' + @Date_column + '
       )
       SELECT * INTO ' + QUOTENAME(@DB_LINK) + '.' + QUOTENAME(@DB_name_dest) + '.' + QUOTENAME(@Schema) + '.' + QUOTENAME(@Table) +' FROM CTE 
END

SELECT * FROM ' + QUOTENAME(@DB_LINK) + '.' + QUOTENAME(@DB_name_dest) + '.' + QUOTENAME(@Schema) + '.' + QUOTENAME(@Table) + ''

SET @ParmDefinition = N'@Maxrows_IN INT, @Keepdays_IN INT'

EXECUTE sp_executesql @SQLString, @ParmDefinition, @Maxrows_IN = @Maxrows, @Keepdays_IN = @Keepdays

--SELECT TOP 100 * FROM [HJWMS].AAD.dbo.v_tran_log WITH (NOLOCK)
