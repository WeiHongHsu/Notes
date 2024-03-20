DECLARE @listname nvarchar(50)
DECLARE @SQLStr nvarchar(Max) = '' 
DECLARE @SQLStr2 nvarchar(Max) 

set @listname = 'SMSInfo'

set @SQLStr2 = ' @listname nvarchar(50) '

set @sqlstr = @sqlstr + ' Create table #temp '
set @sqlstr = @sqlstr + ' ( '
set @sqlstr = @sqlstr + '	 [listname] nvarchar(50) '
set @sqlstr = @sqlstr + '	,[code] nvarchar(50) '
set @sqlstr = @sqlstr + '	,[Description] nvarchar(50) '
set @sqlstr = @sqlstr + '	,[short] nvarchar(50) '
set @sqlstr = @sqlstr + '	,[long] nvarchar(50) '
set @sqlstr = @sqlstr + '	,[Storerkey] nvarchar(50) '
set @sqlstr = @sqlstr + ' ) '
set @sqlstr = @sqlstr + ' insert into #temp '
set @sqlstr = @sqlstr + ' exec test @listname '
set @sqlstr = @sqlstr + ' select * from #temp '

exec sp_executesql @SQLStr,@SQLStr2,@listname

exec test 'SMSInfo'

select * from ##Temp

drop table ##Temp



