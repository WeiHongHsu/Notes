exec master..xp_cmdshell 'whoami';


exec master..xp_cmdshell 
'SQLCMD 
-U sa   
-P zaq1 
-d eCaps  
-h 
-q 
"SET NOCOUNT on select top 10 * from [dbo].[TX_SOD] (nolocK)" 
-u 
-s "	" 
-w 5000 
-W 
-o D:\SJOB\text.csv'

select top 10 * from [dbo].[TX_SOD] (nolocK)


