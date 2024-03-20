
--/*�إߺʱ������X�R�ƥ�*/
--CREATE EVENT SESSION DeadLock ON SERVER
--ADD EVENT sqlserver.xml_deadlock_report
--ADD TARGET package0.event_file
--(
--    SET FILENAME = N'D:\Deadlock\DeadLock.xel', --LOG�s���m
--    METADATAFILE = 'D:\Deadlock\DeadLock.xel'
--)
/*�Ұ��X�R�ƥ�*/
--ALTER EVENT SESSION DeadLock
--      ON SERVER
--    --ON DATABASE
--STATE = START;   -- STOP;

/*�d���X�R�ƥ󤺮e*/
SELECT object_name
      ,file_name
,convert(xml,event_data).query('/event/data/value/deadlock') as DeadLockGraph
FROM sys.fn_xe_file_target_read_file('D:\Deadlock\*.xel', null , null, null)  
where object_name = 'xml_deadlock_report'


DECLARE @xml xml
SELECT @xml = event_data      
 FROM sys.fn_xe_file_target_read_file('D:\Deadlock\*.xel', null , null, null);  

SELECT @xml.query('/event/data/value/deadlock') 

