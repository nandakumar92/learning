

select
a.EmployeeID,
BirthDate,
timestampdiff(YEAR,BirthDate,current_date()) as yrs,
b.Rate
from employee a 
join
(
select
EmployeeID,
Rate
from
(
select
EmployeeID,
Rate,
rank()over(partition by EmployeeID order by RateChangeDate desc) as rnk
from
employeepayhistory
)a
where rnk=1
)b
on a.EmployeeID=b.EmployeeID
