

select
a.SalesOrderID,
cast(a.OrderDate as date) as OrderDate,
sum(c.DiscountPct*SubTotal) as discounted_total
from
salesorderheader a
join salesorderdetail b
on a.SalesOrderID=b.SalesOrderID
join specialoffer c
on b.SpecialOfferID=c.SpecialOfferID
group by 
1,2
having(sum(c.DiscountPct*SubTotal)>0)