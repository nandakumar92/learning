
select
* from (
select
a.ProductID,
a.Name,
c.Name as scrapreason,
count(*) as cnt,
rank()over(partition by a.ProductID order by count(*) desc ) as rnk
from product a 
join workorder b
on a.ProductID=b.ProductID
join scrapreason c
on b.ScrapReasonID=c.ScrapReasonID
group by 
1,2,3
)a
where rnk=1