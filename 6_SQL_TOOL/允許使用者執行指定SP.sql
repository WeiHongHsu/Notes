--Drop ROLE NewRole ;  --建立新的伺服器腳色
/*允許使用者執行指定SP*/
GRANT EXECUTE ON  [SPName] TO Report_Read_Only ;  
/*拒絕使用者執行指定SP*/
REVOKE EXECUTE ON OBJECT:: [SPName] FROM Report_Read_Only ;