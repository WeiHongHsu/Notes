/*取網段語法*/
DECLARE @ClientIP NVARCHAR(48);
SET @ClientIP = CAST(CONNECTIONPROPERTY('client_net_address') AS VARCHAR(50));
SET @ClientIP = '192.168.10.16'
SELECT @ClientIP
select SUBSTRING(@ClientIP ,
CHARINDEX('.', @ClientIP, CHARINDEX('.', @ClientIP)+ 1)+1,
((CHARINDEX('.', @ClientIP, CHARINDEX('.', @ClientIP, CHARINDEX('.', @ClientIP)+1)+1)-1)) - (CHARINDEX('.', @ClientIP, CHARINDEX('.', @ClientIP)+ 1)))
