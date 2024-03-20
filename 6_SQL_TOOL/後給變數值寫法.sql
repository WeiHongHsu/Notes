DECLARE @sql nvarchar(max)
SET @sql = 'SELECT * FROM dbo.codelkup WHERE code = @code'
EXECUTE sp_executesql @sql
, N'@code nvarchar(50)' --宣告變數
, N'Route' --給變數@code值
