SELECT o.name ,o.xtype , c.text FROM SYS.SYSOBJECTS  o
inner join SYS.SYSCOMMENTS c on o.id =c.id
WHERE xtype<>'D' -- D �O��ܹw�]�ȩҥH����
order by xtype