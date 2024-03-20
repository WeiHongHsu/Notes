select spid,login_time,last_batch,status,hostname,db_name(dbid) dbname,program_name,cmd,loginame
from master.dbo.sysprocesses
where len(hostname) > 1 
order by last_batch,hostname
