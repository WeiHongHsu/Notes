 /*�ˬdMAIL�O�_���e�X*/
 select * from msdb.dbo.sysmail_event_log with (nolocK) 
 where convert(char(8),last_mod_date,112) >= convert(char(8),getdate(),112) order by last_mod_date desc
