
select
a.ProductId,
c.Name as productname,
a.color,
a.ListPrice,
sum(b.Quantity) as quty
from product a
join productinventory b
on a.ProductId=b.ProductId
join ProductModel c
on a.ProductModelID =c.ProductModelID
where FinishedGoodsFlag=1 and ListPrice>=1500
group by 
1,2,3,4