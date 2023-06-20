

select
a.SalesPersonId,
b.Name ,
sum(SubTotal) as sales
from
salesorderheader a
join
salesterritory b
on a.TerritoryID=b.TerritoryID
where year(a.OrderDate)='2001'
and b.Name in ('Northwest','Canada','Southwest')
and a.SalesPersonId is not null
group by 
1,2