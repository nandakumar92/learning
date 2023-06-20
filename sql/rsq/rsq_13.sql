select
right(a.NationalIDNumber,4) as id,
b.FirstName,
b.LastName,
a.Title,
a.VacationHours
from
employee a 
join contact b
on a.EmployeeID=b.ContactID
join
(
select
max(VacationHours)  as hrs
from 
employee
)c
on a.VacationHours=c.hrs