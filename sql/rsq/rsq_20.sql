

select
c.FirstName,
c.LastName,
a.Title,
a.BirthDate,
a.HireDate,
a.MaritalStatus
from
employee a 
join contact c
on a.EmployeeID=c.ContactID
join employeedepartmenthistory b
on a.EmployeeID=b.EmployeeID
and b.EndDate is null
join department d
on b.DepartmentID=d.DepartmentID
and d.Name='Marketing'
join
(
select
EmployeeID,
min(HireDate) as mindt,
max(HireDate) as maxdt
from
employee
group by 
1
)e
on a.EmployeeID=e.EmployeeID
where year(e.mindt)>='2003' or year(e.maxdt)<'2001'