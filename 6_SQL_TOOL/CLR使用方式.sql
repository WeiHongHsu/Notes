/*CLR 使用方式 33/SJOB */

/*GetFiles 查詢目標資料夾,檔名類型*/
select * from SJOB.[dbo].[GetFiles]('Z:\backup\toeslite\SAP\EX08\','*.PUB')

/*FileCopy 複製目標檔案,複製至目標位置*/
select [dbo].[FileCopy]('Z:\backup\toeslite\SAP\EX08\EX08_DB99_0867507220.PUB','\\192.168.1.25\跨部門共用區\Jacky\檔案備份\EX08_DB99_0867507220.PUB')

/*FileCopy 搬移目標檔案,搬移目標位置*/
select [dbo].[FileMove] ('\\192.168.1.25\跨部門共用區\Jacky\檔案備份\EX08_DB99_0867507220.PUB','\\192.168.1.25\跨部門共用區\Jacky\檔案備份\G016221112\EX08_DB99_0867507220.PUB')