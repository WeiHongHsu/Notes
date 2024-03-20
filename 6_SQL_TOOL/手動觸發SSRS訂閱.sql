--use ReportServer$HJWMS

SELECT
SubscriptionID
,Description

,*
FROM
ReportServer$HJWMS.dbo.Subscriptions WITH (NOLOCK)
WHERE
Description like '%Delay%' --> 訂閱名稱


DECLARE
@sub_id	uniqueidentifier

SELECT
@sub_id = SubscriptionID
FROM
ReportServer$HJWMS.dbo.Subscriptions WITH (NOLOCK)
WHERE
Description = 'EC_Delay30_HOLD' --> 訂閱名稱

EXEC ReportServer$HJWMS.dbo.AddEvent 
@EventType			= 'TimedSubscription'
, @EventData		= @sub_id


