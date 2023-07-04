
with data as (
select
SalesPersonID,
sum(SubTotal) as total,
rank()over(order by sum(SubTotal) desc) as top_rnk,
rank()over(order by sum(SubTotal) asc) as low_rnk
from
salesorderheader
where year(OrderDate)=2001
and SalesPersonID is not null
group by
1
)

select
a.SalesPersonID,
a.total,
b.SalesPersonID,
b.total
from
(select * from data where top_rnk<=5) a 
join
(select * from data where low_rnk<=5) b
on a.top_rnk=b.low_rnk

