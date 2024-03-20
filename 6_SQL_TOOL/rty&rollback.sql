
Declare @a INT = '1'
  ,@errmsg Nvarchar(100)

Begin tran settran

Begin try
  SET @a = 'A'
end try
begin catch
   Rollback tran settran
   SET @errmsg = ERROR_MESSAGE()
end catch

IF @errmsg is null 
  Commit tran  settran

Select @a