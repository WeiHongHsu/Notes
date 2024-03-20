use Vendor_AGV
--查詢索引破碎率 
SELECT OBJECT_NAME(dt.object_id)      ,
       si.name                        ,
       dt.avg_fragmentation_in_percent,
       dt.avg_page_space_used_in_percent
FROM
       (SELECT object_id                   ,
               index_id                    ,
               avg_fragmentation_in_percent,
               avg_page_space_used_in_percent
       FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'DETAILED')
       WHERE   index_id <> 0
       ) AS dt --does not return information about heaps
       INNER JOIN sys.indexes si
       ON     si.object_id = dt.object_id
          AND si.index_id  = dt.index_id

--查詢哪個索引需要重建

SELECT 'ALTER INDEX [' + ix.name + '] ON [' + s.name + '].[' + t.name + '] ' +
       CASE
              WHEN ps.avg_fragmentation_in_percent > 15
              THEN 'REBUILD'
              ELSE 'REORGANIZE'
       END +
       CASE
              WHEN pc.partition_count > 1
              THEN ' PARTITION = ' + CAST(ps.partition_number AS nvarchar(MAX))
              ELSE ''
       END,
       avg_fragmentation_in_percent
FROM   sys.indexes AS ix
       INNER JOIN sys.tables t
       ON     t.object_id = ix.object_id
       INNER JOIN sys.schemas s
       ON     t.schema_id = s.schema_id
       INNER JOIN
              (SELECT object_id                   ,
                      index_id                    ,
                      avg_fragmentation_in_percent,
                      partition_number
              FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL)
              ) ps
       ON     t.object_id = ps.object_id
          AND ix.index_id = ps.index_id
       INNER JOIN
              (SELECT  object_id,
                       index_id ,
                       COUNT(DISTINCT partition_number) AS partition_count
              FROM     sys.partitions
              GROUP BY object_id,
                       index_id
              ) pc
       ON     t.object_id              = pc.object_id
          AND ix.index_id              = pc.index_id
WHERE  ps.avg_fragmentation_in_percent > 10
   AND 
   ix.name IS NOT NULL


--ALTER INDEX [NonClusteredIndex-20211023-171933] ON [dbo].[Ewms_order] REBUILD
--ALTER INDEX [IDX_ATH_RECEIPT_receipt_code_ctyps] ON [dbo].[ATH_RECEIPT] REBUILD
--ALTER INDEX [NonClusteredIndex-20211026-204907] ON [dbo].[ATH_RECEIPT] REBUILD
--ALTER INDEX [NonClusteredIndex-20201114-113322] ON [dbo].[HTA_ORDER] REBUILD
--ALTER INDEX [NonClusteredIndex-20201114-113209] ON [dbo].[HTA_ORDERD] REBUILD
--ALTER INDEX [NonClusteredIndex-20210429-154459] ON [dbo].[ATH_CASE] REBUILD
--ALTER INDEX [NonClusteredIndex-20211022-160839] ON [dbo].[ATH_CASE] REBUILD
--ALTER INDEX [NonClusteredIndex-20210429-154036] ON [dbo].[ATH_CASED] REBUILD
--ALTER INDEX [_ix_ATH_RECEIPTD_01] ON [dbo].[ATH_RECEIPTD] REBUILD
--ALTER INDEX [IDX_ATH_RECEIPTD_receipt_code] ON [dbo].[ATH_RECEIPTD] REBUILD
--ALTER INDEX [NonClusteredIndex-20200904-102334] ON [dbo].[CLR_API_LOG] REBUILD
--ALTER INDEX [IDX_ATH_ORDER_out_order_code_ctyps] ON [dbo].[ATH_ORDER] REBUILD