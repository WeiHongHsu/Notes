SELECT *  FROM [SMS].[dbo].[SMS_Codelookup]
SELECT *  FROM [SMS].[dbo].[SMS_Codelist]


Declare @msg nvarchar(2000),@sql nvarchar(1000)
Declare @subject nvarchar(200) = '[P1]EC發運批次監控_異常請注意[OP]'
SET @msg = ' 發運批次 : Test | '
SET @msg+= ' 應發運時間 :' + cast(FORMAT (getdate(), 'yyyy/dd/MM, hh:mm:ss ') AS nvarchar (50)) + ' | '
SET @msg+= ' 剩餘不到30分鐘 || '
SET @msg+= ' 報表網址 : http://hjdata.edl/ReportServer_HJWMS/Pages/ReportViewer.aspx?%2feWMS%2feWMS_EC_Ship_status&rs:Command=Render'
SET @sql = 'SELECT getdate() as 檢查時間'  
SET @msg=REPLACE(@msg,'|','<br />')
select @msg

exec [dbo].[SP_ALTER_FOR_MAIL_SMS] 'EC_SHIP_STATUS','mail','ESL',@msg,@sql

--exec [dbo].[TsSJOBMAIL_TEST] 'EC_SHIP_STATUS','',@sql,@Subject,@msg

  --insert into [SMS].[dbo].[SMS_Codelookup] ( listname ,code,description,storerkey,UDF01,UDF02,UDF03)
  --select 'MailInfo' , 'EC_SHIP_STATUS','EC發運批次警告','ESL','[P1]EC發運批次監控_異常請注意[OP]','',''
