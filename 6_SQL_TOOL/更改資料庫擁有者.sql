/*����Ʈw�֦���*/

SELECT d.name N'��Ʈw',
       p.name N'��Ʈw�֦���',
       d.owner_sid N'�w�����ѧO�X',
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