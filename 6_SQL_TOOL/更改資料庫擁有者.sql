/*更改資料庫擁有者*/

SELECT d.name N'資料庫',
       p.name N'資料庫擁有者',
       d.owner_sid N'安全性識別碼',
       is_read_only,
       state_desc
FROM   sys.databases d
INNER  JOIN sys.server_principals p
ON     d.owner_sid = p.sid
WHERE  state = 0
AND    is_read_only = 0
AND    d.name NOT IN ('master', 'model', 'tempdb', 'distribution')
ORDER  BY p.name;


USE xxx
GO

ALTER AUTHORIZATION ON DATABASE::xxx TO sa
GO