SELECT a.JobID
,a.EmailName
,MAX(a.FromName) as FromName
,MAX(a.EmailSubject) as Subject
,max(FORMAT(b.EventDate, 'dd/MM/yyyy')) as [SentDate]
,count(Distinct(b.subscriberkey)) as Sent
,count(Distinct(c.subscriberkey)) as Opened
,count(Distinct(d.subscriberkey)) as Bounced
,count(Distinct(e.subscriberkey)) as Clicked
,(count(Distinct(b.subscriberkey)) - count(Distinct(d.subscriberkey))) as Delivered
,count(Distinct(f.subscriberkey)) as Unsubscribed
FROM _Job a
INNER JOIN 
_Sent b
ON a.jobid = b.jobid
LEFT JOIN
_Open c
ON a.jobid = c.jobid AND b.subscriberkey = c.subscriberkey
LEFT JOIN
_Bounce d
ON a.jobid = d.jobid AND b.subscriberkey = d.subscriberkey
LEFT JOIN
_Click e
ON a.jobid = e.jobid AND b.subscriberkey = e.subscriberkey
LEFT JOIN
_Unsubscribe f
ON a.jobid = f.jobid AND b.subscriberkey = f.subscriberkey
WHERE MONTH(b.EventDate) = DATEPART(M, DATEADD(MONTH, -1, GETDATE()))
AND a.EmailSubject not like '%test%'
GROUP BY a.emailname, a.jobid
