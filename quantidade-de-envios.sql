SELECT COUNT(Id), CreatedDate, CreatedById
FROM EmailMessage
WHERE CreatedDate >= LAST_N_DAYS:150
GROUP BY CreatedDate, CreatedById
ORDER BY CreatedDate
