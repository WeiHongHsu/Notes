
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
/********************************************************************
-- Author:		路線同步排程 (ECR:EA16_CR_202205_0006)
-- Create date: 2022/05/25 by JackyHsu
-- Description:	檔案固定命名為Route_2022.xlsx
				User維護完成後將檔案放置於\\192.168.1.25\apprt\EDI_EXCEL\
參照範本規則:  
•檔案名:ROUTE_2022.xlsx  固定 。
•Sheet頁簽: ROUTE 固定。
依ROUTE_2022.xlsx   內容全部更新，更新之後不會保留前次數據，
Excel檔案格式
[車隊]
[車隊名]
[路線]
[流道]: 設1~7 數字。
[供應商代號] :值必需文字
[供應商名]
[供應商短名]

********************************************************************/

--CREATE PROCEDURE Route_sync 

--AS
--BEGIN
--	SET NOCOUNT ON;
	
	IF OBJECT_ID('tempdb.dbo.#temp') IS NOT NULL
	BEGIN
		DROP TABLE #temp
	END

	Create table #temp
	(
		 CarID varchar(20)
		,CarName nvarchar(200)
		,Route varchar(30)
		,Door varchar(30)
		,VND varchar(15)
		,VNDname nvarchar(200)
		,SorName nvarchar(200)
		,status nvarchar(2) DEFAULT '1'
	)

	/*讀取EXCEL檔案資料*/
	DECLARE 
		 @path nvarchar(200) --檔案路徑
		,@filename nvarchar(50) --檔案名稱
		,@BakPath nvarchar(400) --備份路徑
		,@backfilename nvarchar(50) --備份檔案名稱
		,@Sheetname nvarchar(50) --Excel頁面名稱
		,@FilePath nvarchar(400) --完整路徑(含黨名)
		,@Excel_column nvarchar(200) --Excel欄位
		,@sql nvarchar(max) 
	
	select 
	 @filename = filename +Filetype
	,@backfilename = filename +'_'+ convert(char(8),getdate(),112) + Filetype
	,@path = path
	,@BakPath = BackPath + filename +'_'+ convert(char(8),getdate(),112) + Filetype
	,@Sheetname = Sheetname
	,@Excel_column = Excel_column
	from  [dbo].[Codelkup] where code = 'Route_Excel'
	
	select @filename,@backfilename,@path,@BakPath,@Sheetname
	,@path + @filename

	/*參數設定*/
	--set @filename = 'ROUTE_2022.xlsx'
	--set @backfilename = 'ROUTE_2022_'+convert(char(8),getdate(),112)+'.xlsx'
	--set @Sheetname = 'ROUTE'
	--set @path = '\\192.168.1.25\apprt\EDI_EXCEL\'
	--set @BakPath = '\\192.168.1.25\apprt\EDI_EXCEL\bak\'+ @backfilename
	set @FilePath = @path + @filename

	--select @path,@filename,@Sheet,@Sheetname,@FilePath
	
	/*檢查檔案是否存在*/
	declare @result int
	exec xp_fileexist @FilePath, @result out

	if @result = 0
		begin 
			print '無檔案'
			Return
		end
	else 
		begin

			/*設定抓黨路徑*/
			set @sql = 'select * '
			--set @sql = @sql +'車隊,車隊名,路線,流道,供應商代號,供應商名,供應商短名	 '
			set @sql = @sql +' FROM   OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0;Database='+@FilePath+''',['+ @Sheetname +'$] ) as A  '
			set @sql = @sql +' where 路線 IS NOT NULL  '

			/*將資料寫入暫存*/
			exec sp_sqlexec @sql
			
			/*備份原始檔案*/
			DECLARE @cmdstr varchar(500) ='move '+ @FilePath +' '+@BakPath+''
			select @cmdstr
			EXEC master..xp_cmdshell @cmdstr

			/*將舊資料更新*/
			--update RouteDoor set Status= -9

			/*寫入新增資料*/
			--insert iexp.dbo.RouteDoor(CarID , CarName ,Route ,Door ,VND, VNDname  ,SorName,Status)
			select CarID , CarName ,Route ,Door ,VND, VNDname  ,SorName,Status from #temp
			
			/*更新主黨*/
			--update STORERD 
			--set ShuntStation='E10'+Door,SHORTNAME=SorName
			--from  iexp..RouteDoor
			--where VND=HostReference  
			--and RouteDoor.status= 1
			
			/*通部WES路線主檔並刪除舊資料*/
			--IF @@ROWCOUNT>0
			--	Begin
			--	--update [EDL_WES].eCaps.dbo.RouteDoor  set status=-9
			--	--insert [EDL_WES].eCaps.dbo.RouteDoor 
			--	select *  from iexp..RouteDoor where status= 1
			--	--delete [EDL_WES].eCaps.dbo.RouteDoor  where status=-9
			--	--delete  iexp..RouteDoor  where status=-9
			--	End
		end
--END

