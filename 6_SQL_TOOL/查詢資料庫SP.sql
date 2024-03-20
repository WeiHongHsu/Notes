SELECT o.name ,o.xtype , c.text FROM SYS.SYSOBJECTS  o
inner join SYS.SYSCOMMENTS c on o.id =c.id
WHERE xtype<>'D' -- D 是顯示預設值所以不看
order by xtype