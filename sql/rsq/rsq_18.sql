
select
a.ProductID,
a.Name,
b.Name as subcategory,
max(c.StandardCost) as max_cost,
min(c.StandardCost) as min_cost,
max(c.StandardCost) - min(c.StandardCost)  as var,
dense_rank()over(order by max(c.StandardCost) - min(c.StandardCost) desc) as rnk
from
product a 
join 
productsubcategory b
on a.ProductSubcategoryID=b.ProductSubcategoryID
join productcosthistory c
on a.ProductID=c.ProductID
group by 
1,2,3

