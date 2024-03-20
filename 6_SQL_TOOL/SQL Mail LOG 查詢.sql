/*保存已成功發送的郵件項目的記錄*/
SELECT * FROM msdb.dbo.sysmail_sentitems where subject='每月Excel密碼更改通知' order by sent_date desc
/*保存發送失敗的郵件項目的記錄*/
SELECT * FROM msdb.dbo.sysmail_faileditems where subject='每月Excel密碼更改通知' order by sent_date desc
/*保存未成功發送的郵件項目的記錄*/
SELECT * FROM msdb.dbo.sysmail_unsentitems



