/*33 JOB 資料*/
select * from [192.168.1.33\SJOB].sjob.dbo.jobq with (nolocK) where wkey = '202205014756301'
select * from [192.168.1.33\SJOB].sjob.dbo.jobq with (nolocK) where wkey = '202203226713901'


select serr,* from [192.168.1.33].sjob.dbo.jobq with (nolocK) where wkey like '%202205014756301%'
select serr,* from [192.168.1.33].sjob.dbo.jobq with (nolocK) where wkey like '%202203226713901%'

select rdo,* from [192.168.1.33].sjob.dbo.jobq with (nolocK) where pid = '537538'
--update [192.168.1.33].sjob.dbo.jobq  set rdo = '2' where wkey like '%202203226713901%' and pid = '537538'

/*33 Gatway 訂單資料*/
select * from [192.168.1.33].iexp.dbo.SOhost with (nolocK)  where externorderkey = '202205014756301'
select * from [192.168.1.33].iexp.dbo.SOD with (nolocK) where externorderkey = '202205014756301'

select * from [192.168.1.33].iexp.dbo.SOhost with (nolocK)  where externorderkey = '202203226713901'
select * from [192.168.1.33].iexp.dbo.SOD with (nolocK) where externorderkey = '202203226713901'


/*11 eWms資料*/
select * from orders (nolocK) where externorderkey = '202205014756301'
select * from orders (nolocK) where externorderkey = '202203226713901'

/*134 TO eCAPS (WES)*/
select * from [192.168.1.134].ecaps.dbo.[TX_SOM] with (nolocK) where sono = '202205014756301'
select * from [192.168.1.134].ecaps.dbo.[TX_SOD] with (nolocK) where sono = '202205014756301'

select * from [192.168.1.134].ecaps.dbo.[TX_SOM] with (nolocK) where sono = '202203226713901'
select * from [192.168.1.134].ecaps.dbo.[TX_SOD] with (nolocK) where sono = '202203226713901'




