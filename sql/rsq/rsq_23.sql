

select
a.TerritoryID,
b.Name,
year(a.OrderDate) as yr,
sum(a.SubTotal) as rev,
rank()over(partition by year(a.OrderDate)  order by sum(a.SubTotal) desc) as rnk
from
salesorderheader a 
join salesterritory b
on a.TerritoryID=b.TerritoryID
group by 
1,2,3
order by 
3,5
