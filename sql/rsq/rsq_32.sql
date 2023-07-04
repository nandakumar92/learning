
select
ProductId,
ListPrice - StandardCost as profit,
round((ListPrice - StandardCost)/ListPrice,4)*100 as margin
from
product
where ListPrice>0 and StandardCost>0
