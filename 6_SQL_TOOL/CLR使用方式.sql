/*CLR �ϥΤ覡 33/SJOB */

/*GetFiles �d�ߥؼи�Ƨ�,�ɦW����*/
select * from SJOB.[dbo].[GetFiles]('Z:\backup\toeslite\SAP\EX08\','*.PUB')

/*FileCopy �ƻs�ؼ��ɮ�,�ƻs�ܥؼЦ�m*/
select [dbo].[FileCopy]('Z:\backup\toeslite\SAP\EX08\EX08_DB99_0867507220.PUB','\\192.168.1.25\�󳡪��@�ΰ�\Jacky\�ɮ׳ƥ�\EX08_DB99_0867507220.PUB')

/*FileCopy �h���ؼ��ɮ�,�h���ؼЦ�m*/
select [dbo].[FileMove] ('\\192.168.1.25\�󳡪��@�ΰ�\Jacky\�ɮ׳ƥ�\EX08_DB99_0867507220.PUB','\\192.168.1.25\�󳡪��@�ΰ�\Jacky\�ɮ׳ƥ�\G016221112\EX08_DB99_0867507220.PUB')