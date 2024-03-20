


DECLARE @StatusMsg  nvarchar(4000)= '<?xml version="1.0" encoding="UTF-8"?>
<Doc>   
<OrderNo><![CDATA[03716800001]]></OrderNo>   
<ErrorCode><![CDATA[000]]></ErrorCode>   
<ErrorMessage><![CDATA[成功]]></ErrorMessage> 
</Doc>
'
select CHARINDEX( '<Doc>' ,@StatusMsg)
DECLARE @StatusMsg2 XML
select @StatusMsg2 = substring(@StatusMsg,CHARINDEX( '<Doc>' ,@StatusMsg),len(@StatusMsg))
select @StatusMsg2

SELECT left(@StatusMsg2.value('(/Doc/OrderNo)[1]', 'varchar(50)'),6)  as keygr,
right(rtrim(@StatusMsg2.value('(/Doc/OrderNo)[1]', 'varchar(50)')),5)  as keycount
