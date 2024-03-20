--***************
--找關鍵字
--***************/
SELECT distinct
'type' = case type
when 'FN' then 'Scalar function'
when 'IF' then 'Inlined table-function'
when 'P' then 'Stored procedure'
when 'TF' then 'Table function'
when 'TR' then 'Trigger'
when 'V' then 'View'
end,
o.[name]
--watchword = @object
FROM dbo.sysobjects o (NOLOCK)
JOIN dbo.syscomments c (NOLOCK)
ON o.id = c.id
where c.text like '%Bcp_Query_byInfKey%'