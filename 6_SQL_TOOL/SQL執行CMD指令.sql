DECLARE @cmdstr varchar(500) ='move D:\JackyHsu\test\test.txt D:\JackyHsu\test\bak\test_' + convert(char(8),getdate(),112) + '.txt'
select @cmdstr
EXEC master..xp_cmdshell @cmdstr
