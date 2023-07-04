
select
b.DepartmentId,
a.EmployeeId,
case when Suffix is not null then concat(c.FirstName,' ',c.LastName,',',c.Suffix) 
else concat(c.FirstName,' ',c.LastName) end as name_tag
from
employee a 
join employeedepartmenthistory b
on a.EmployeeID=b.EmployeeID
join contact c
on c.ContactID=a.EmployeeID
