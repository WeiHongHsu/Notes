    SELECT r.session_id,
    r.status AS [���O���A],
    r.command AS [���O����],
    r.wait_time/1000.0 AS [���ݮɶ�(��)],
    s.client_interface_name AS [�s�u��Ʈw���X�ʵ{��],
    s.host_name AS [�q���W��],
    s.program_name AS [����{���W��],
    t.text AS [���檺SQL�y�k],
    r.blocking_session_id AS [�Q��w�d��session_id]
    FROM sys.dm_exec_requests r
    INNER JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
    CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
    WHERE s.is_user_process = 1
	and r.session_id <> @@SPID
