	IF OBJECT_ID('tempdb.dbo.#temp') IS NOT NULL
	BEGIN
		DROP TABLE #temp
	END


select * from #temp


DECLARE @wkey nvarchar(30)

While (1=1)
	begin
		if not EXISTS (select top 1 * from #temp)
		begin 
			break
		end

		select top 1  @wkey = wkey from #temp
				
		select @wkey
		/*³B²z*/


		delete #temp where wkey = @wkey

end