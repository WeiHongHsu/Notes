/*印表機清單*/
select printer_id, 
case when left(printer_id,3) = 'A16' then '192.168.19.183'
when left(printer_id,2) = 'A4' then '192.168.19.185'
when left(printer_id,2) = 'EC' then '192.168.19.184'
end
,*
from _t_printer_mapping (nolocK) 
where left(workstation_id ,7) = 'LPWPACK'
and left(printer_id,2) not in ( 'CB','PR')
and left(printer_id,2) in ( 'EC')
and report_name not in ( 'HJ_RPT_WavePickList_A4L','')
and workstation_id in (select device_id from [dbo].[_t_device] (nolocK) 
where left(device_description ,2) in ('3F','4F' )
and device_type = 'PC'
and left(device_id ,7) = 'LPWPACK')
--order by printer_id 


select * from _t_printer_mapping (nolock) where workstation_id = 'LPWPACK0002'

select * from _t_Bartender_API_LOG (nolock) order by id desc