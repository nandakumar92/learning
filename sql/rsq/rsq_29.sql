
SELECT
b.Title,
case when round(datediff('2001-01-01',b.BirthDate)/365,0)<18 then '<18'
when round(datediff('2001-01-01',b.BirthDate)/365,0) between 18 and 35 then '18-35'
when round(datediff('2001-01-01',b.BirthDate)/365,0) between 36 and 50 then '36-50' end as age_group,
rate,
count(distinct a.EmployeeId) as employees
from employeepayhistory a
join employee b
on a.EmployeeId=b.EmployeeId
group by 
1,2,3