DECLARE @wkey nvarchar(200)
DECLARE @Source nvarchar(200), @FileName nvarchar(50),@Dest nvarchar(200), @FileName2 nvarchar(50)
		set @Source = '\\192.168.1.68\backup\eslite\e1\'  --取檔路徑
		set @Dest = '\\192.168.1.25\跨部門共用區\Jacky\檔案備份\' --暫存目錄

	IF OBJECT_ID('tempdb.dbo.#temp') IS NOT NULL
	BEGIN
		DROP TABLE #temp
	END

/*設定資料範圍*/
select distinct WKEY 
into #temp
from sjob.dbo.jobq with (nolocK) 
where LotKey2 in  
(
 '202308284651001'
,'202308280647801'
,'202308298602501'
,'202308290197501'
,'202308294631801'
,'202308299203701'
,'202308294871901'
,'202308290472901'
)
and infid = 'EC19'



While (1=1)
	begin
		if not EXISTS (select top 1 * from #temp)
		begin 
			break
		end

		select top 1  @wkey = wkey from #temp
				
		select @wkey
		/*處理*/

		set @FileName = @wkey
		set @FileName2 = @wkey
		select @Source+@FileName ,@Dest+@FileName2
		select [dbo].[FileCopy](@Source+@FileName,@Dest+@FileName2)

		delete #temp where wkey = @wkey

end









--select *
--from [GATEWAYA\SJOB].sjob.dbo.jobq with (nolocK) 
--where lotkey1 = '1030025304' and infid = 'EX01'


--select status,EXTERNSOSTATUS,* 
--from orders (nolocK) 
--where externorderkey in 
--('0867456635'
--,'0867456636'
--,'0867456637'
--,'0867456638'
--,'0867456639'
--,'0867456640'
--,'0867456641'
--,'0867456642'
--,'0867456643'
--,'0867456644'
--,'0867456645'
--,'0867456646'
--,'0867456647'
--,'0867456648'
--,'0867456649'
--,'0867456650'
--,'0867456703'
--,'0867458055'
--,'0867456677'
--,'0867456678'
--,'0867456679'
--,'0867458198'
--,'0867458199'
--,'0867458200'
--,'0867458201'
--,'0867458202'
--,'0867458203'
--,'0867458204'
--,'0867458205'
--,'0867458206'
--,'0867458247'
--,'0867458207'
--,'0867458208')


--select * from receipt (nolocK) where EXTERNRECEIPTKEY = '1030025304'
