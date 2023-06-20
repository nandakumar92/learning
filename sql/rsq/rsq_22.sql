
select
a.SalesOrderID,
a.CustomerID,
d.Name as product,
b.FirstName,
b.LastName
from
salesorderheader a
join contact b
on a.CustomerID=b.ContactID
join salesorderdetail c
on a.SalesOrderID=c.SalesOrderID
join product d on
c.ProductID=d.ProductID
where a.OrderDate>='2001-07-01' and lower(d.Name) like '%shorts%'
