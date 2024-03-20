/*清除HJ至WES語法*/

select * 
from tx_SOM (nolocK) where sono in ('1710160959','1710161095','1710160926')
select * 
from tx_SOD (nolocK) where sono in ('1710160959','1710161095','1710160926')

begin tran
delete tx_SOM  where sono in ('1710160959','1710161095','1710160926')
delete tx_SOD  where sono in ('1710160959','1710161095','1710160926')
rollback tran


select * from [HJWMS].[Vendor_WES].dbo.hte_so with (nolock) where sono in ('1710160959','1710161095','1710160926')
select * from [HJWMS].[Vendor_WES].dbo.hte_soD with (nolock) where sono in ('1710160959','1710161095','1710160926')


delete [HJWMS].[Vendor_WES].dbo.hte_so  where sono in ('1710160959','1710161095','1710160926')
delete [HJWMS].[Vendor_WES].dbo.hte_soD  where sono in ('1710160959','1710161095','1710160926')