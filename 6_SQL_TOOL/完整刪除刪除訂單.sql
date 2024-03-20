select * from pohost (nolocK) where EXTERNPOKEY in ( '1950000001','1950000002')
select * from poD (nolocK) where EXTERNPOKEY in ( '1950000001','1950000002')
select * from Xsohost (nolocK) where BUYERPO in ('1950000001','1950000002')
select * from XsoD (nolocK) where BUYERPO in ('1950000001','1950000002')

select * from PROD..CaseHead  (nolock) where CaseID in ('C260840001','C260840002','C260840003','C260840004')
select * from PROD..CaseDetail(nolock) where Pokey in ('1950000001','1950000002')
select * from PROD..LogisticsShipDetail (nolock) where CaseID in ('C260840001','C260840002','C260840003','C260840004')

select * from [192.168.1.134].ecaps.dbo.tx_som with (nolocK) where sono in ( '1950000001','1950000002')
select * from [192.168.1.134].ecaps.dbo.tx_soD with (nolocK) where sono in ( '1950000001','1950000002')
select * from [192.168.1.134].ecaps.dbo.tx_BOXM with (nolocK) where boxid in ('C260840001','C260840002','C260840003','C260840004')
select * from [192.168.1.134].ecaps.dbo.tx_BOXD with (nolocK) where POKEY in ( '1950000001','1950000002')
