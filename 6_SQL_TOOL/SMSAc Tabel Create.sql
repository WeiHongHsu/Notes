
/****** Object:  Table [dbo].[SMSAc]    Script Date: 2022/7/21 ¤U¤È 12:24:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SMSAc](
	[UName] [varchar](50) not NULL,
	[MAIL] [varchar](500) NULL,
	[MAIL2] [varchar](500) NULL,
	[TEL] [varchar](200) NULL,
	[MtEvGn] [varchar](500) NULL,
	[MtTran] [varchar](500) NULL,
	[Utype] [varchar](10) NULL,
	[MtWK] [varchar](10) NULL,
	[WFlow] [varchar](100) NULL,
	[NOTE1] [varchar](500) NULL,
	[Note2] [varchar](500) NULL,
	[AddDate] [datetime] null,
	[AddWho] [Varchar](50) null,
	[EditDATE] [datetime] NULL,
	[EDitWho] [Varchar](50),

 CONSTRAINT [PK_SMSAs] PRIMARY KEY CLUSTERED 
(
	[UName] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SMSAc] ADD  CONSTRAINT [DF_SMSAc_Editdate]  DEFAULT (getdate()) FOR [EditDATE]
ALTER TABLE [dbo].[SMSAc] ADD  CONSTRAINT [DF_SMSAc_AddDate]  DEFAULT (getdate()) FOR [AddDate]
ALTER TABLE [dbo].[SMSAc] ADD  CONSTRAINT [DF_SMSAc_AddWho]  DEFAULT (suser_sname()) FOR [AddWho]
ALTER TABLE [dbo].[SMSAc] ADD  CONSTRAINT [DF_SMSAc_EditWho]  DEFAULT (suser_sname()) FOR [EDitWho]



GO


