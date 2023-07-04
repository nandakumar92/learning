

select * from (
select
a.SalesPersonID,
b.LastName,
case when year(QuotaDate)=2001 and quarter(QuotaDate)=2 then SalesQuota end as quota_1,
case when year(QuotaDate)=2001 and quarter(QuotaDate)=3 then SalesQuota end as quota_2,
(case when year(QuotaDate)=2001 and quarter(QuotaDate)=3 then SalesQuota end - case when year(QuotaDate)=2001 and quarter(QuotaDate)=1 then SalesQuota end)/(case when year(QuotaDate)=2001 and quarter(QuotaDate)=1 then SalesQuota end) as change2
from
salespersonquotahistory a 
join contact b
on a.SalesPersonID=b.ContactID
)a
where quota_1 is not null and quota_2 is not null
