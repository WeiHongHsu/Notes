USE [SMS]
GO
/****** Object:  Trigger [dbo].[UPDATETrigger]    Script Date: 2022/7/21 下午 12:09:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JackyHsu
-- Create date: 20220721
-- Description:	資料異動時更新EditDate,EditWho
-- =============================================
ALTER TRIGGER [dbo].[UPDATETrigger] on [dbo].[Codelkup]
	AFTER UPDATE
AS 
BEGIN
	IF (
		   UPDATE(Listname) or UPDATE(code)
		or UPDATE([Description]) or UPDATE([short])
		or UPDATE([long]) or UPDATE([Notes])
		or UPDATE([Notes2]) or UPDATE([Storerkey])
		or UPDATE([UDF01]) or UPDATE([UDF02])
		or UPDATE([UDF03]) or UPDATE([UDF04])
		or UPDATE([UDF05]) or UPDATE([code2])
		) 
	AND EXISTS(SELECT Count(1) FROM [dbo].[Codelkup] WHERE Listname > 0)
	begin

		update [dbo].[Codelkup] set EditDate = getdate() , EditWho = (suser_sname(suser_sid())) 
		from deleted 
		where Codelkup.Listname = deleted.Listname
		and Codelkup.code = deleted.code
				
	end

END
