
select
count(EmployeeID) as emps,
count(case when Gender='M' then EmployeeID end)/count(EmployeeID) as memps,
count(case when Gender='F' then EmployeeID end)/count(EmployeeID) as femps,
AVG(DATEDIFF(MONTH,a.HireDate,'2008-01-01')) as AVG_EMPLOYMENT,
NTILE (4) OVER (ORDER BY DATEDIFF (MONTH, HireDate, '2008-01-01')) as quartile
from
employee a

