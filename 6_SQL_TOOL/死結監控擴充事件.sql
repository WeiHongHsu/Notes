
--/*建立監控死結擴充事件*/
--CREATE EVENT SESSION DeadLock ON SERVER
--ADD EVENT sqlserver.xml_deadlock_report
--ADD TARGET package0.event_file
--(
--    SET FILENAME = N'D:\Deadlock\DeadLock.xel', --LOG存放位置
--    METADATAFILE = 'D:\Deadlock\DeadLock.xel'
--)
/*啟動擴充事件*/
--ALTER EVENT SESSION DeadLock
--      ON SERVER
--    --ON DATABASE
--STATE = START;   -- STOP;

/*查詢擴充事件內容*/
SELECT object_name
      ,file_name
,convert(xml,event_data).query('/event/data/value/deadlock') as DeadLockGraph
FROM sys.fn_xe_file_target_read_file('D:\Deadlock\*.xel', null , null, null)  
where object_name = 'xml_deadlock_report'


DECLARE @xml xml
SELECT @xml = event_data      
 FROM sys.fn_xe_file_target_read_file('D:\Deadlock\*.xel', null , null, null);  

SELECT @xml.query('/event/data/value/deadlock') 

