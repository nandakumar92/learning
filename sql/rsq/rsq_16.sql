
select
a.CustomerID,
b.Name as store_name,
a.SalesOrderID,
max(a.OrderDate) as max_date,
round(datediff('2001-10-07',max(a.OrderDate))/30,0) as months
from
salesorderheader a 
join
store b
on a.CustomerID=b.CustomerID
group by
1,2,3
having(max(a.OrderDate))<='2001-10-07'