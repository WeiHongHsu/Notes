select C_ZIP,* from orders (nolocK) where externorderkey = '202208065849701' 


select C_ZIP,notes,* from orders (nolocK) where left(CONSIGNEEKEY,2) = 'Z2' and ADDDATE >= '20220801'
select C_ZIP,notes,* from orders (nolocK) where isnull(C_ZIP ,'') = '' and left(CONSIGNEEKEY,2) = 'Z2' and ADDDATE >= '20220801'

select PROD.dbo.EDI_EZcatApi_clr('http://192.168.1.52:8800/egs?cmd=query_suda7_dashv2&address_1='+ C_ADDRESS1, 'suda7_1' ),*
 from orders (nolocK) where isnull(C_ZIP ,'') = '' and left(CONSIGNEEKEY,2) = 'Z2' and ADDDATE >= '20220801'

 select PROD.dbo.EDI_EZcatApi_clr('http://192.168.1.52:8800/egs?cmd=query_suda7_dashv2&address_1='+ '台北市中山區德惠街7號', 'suda7_1' )

 exec [192.168.1.33].iexp.dbo._SP_EDI_EZcatApi_clr 'suda7_1',@address,@C_ZIP_ output,@SUSR5 output


