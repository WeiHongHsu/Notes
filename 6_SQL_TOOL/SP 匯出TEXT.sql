--create PROCEDURE dbo.usp_WriteContentToFile
--(
--@Content ntext,
--@Path NVARCHAR(255),
--@Filename NVARCHAR(100)
--)
--AS


--sp_configure 'show advanced options', 1;
--GO
--RECONFIGURE;
--GO
--sp_configure 'Ole Automation Procedures', 1;
--GO
--RECONFIGURE;
--GO


DECLARE
@Content ntext,
@Path NVARCHAR(255),
@Filename NVARCHAR(100)

SELECT 
top 1
--@Filename = sys.sysobjects.name,
@Content = sys.syscomments.text
,@Path = 'C:\Jackyhsu'
FROM sys.sysobjects INNER JOIN syscomments
ON sys.sysobjects.id = sys.syscomments.id
WHERE 
--sys.syscomments.text LIKE '%key_word%'
sys.sysobjects.type = 'P'
ORDER BY sys.sysobjects.NAME

set @Filename = 'text.txt'

DECLARE @objFileSystem int,
@objTextStream int,
@objErrorObject int,
@strErrorMessage nvarchar(1000),
@Command nvarchar(1000),
@hr int,
@fileAndPath nvarchar(100)
set nocount on
select @strErrorMessage='開啟檔案系統物件'
EXECUTE @hr = sp_OACreate 'Scripting.FileSystemObject' , @objFileSystem OUT
Select @fileAndPath=@Path+'\'+@Filename
if @hr=0 Select @objErrorObject=@objFileSystem , @strErrorMessage='檔案建立路徑: '+@fileAndPath+''
if @hr=0 execute @hr = sp_OAMethod @objFileSystem , 'CreateTextFile'
, @objTextStream OUT, @fileAndPath,2,True
if @hr=0 Select @objErrorObject=@objTextStream,
@strErrorMessage='檔案寫入路徑: '+@fileAndPath+''
if @hr=0 execute @hr = sp_OAMethod @objTextStream, 'Write', Null, @Content
if @hr=0 Select @objErrorObject=@objTextStream, @strErrorMessage='檔案關閉: '+@fileAndPath+''
if @hr=0 execute @hr = sp_OAMethod @objTextStream, 'Close'
if @hr<>0
begin
Declare
@Source varchar(255),
@Description varchar(255),
@Helpfile varchar(255),
@HelpID int
EXECUTE sp_OAGetErrorInfo @objErrorObject,
@source output,@Description output,@Helpfile output,@HelpID output
Select @strErrorMessage='Error whilst '
+coalesce(@strErrorMessage,'執行發生錯誤')
+', '+coalesce(@Description,'')
raiserror (@strErrorMessage,16,1)
end
--EXECUTE sp_OADestroy @objTextStream
--EXECUTE sp_OADestroy @objTextStream