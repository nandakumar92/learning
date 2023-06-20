with data as (
select
a.SalesPersonId,
c.LastName,
c.FirstName,
b.Name ,
round(sum(SubTotal),0) as sales
from
salesorderheader a
join
salesterritory b
on a.TerritoryID=b.TerritoryID
join contact c
on a.SalesPersonId=c.ContactID
where year(a.OrderDate)='2001'
and b.Name in ('Northwest','Canada','Southwest')
and a.SalesPersonId is not null
group by 
1,2,3,4
),

tmp_data as (
select
SalesPersonId,
sum(case when Name='NorthWest' then sales end) as nw_sales,
sum(case when Name='Canada' then sales end) as ca_sales,
sum(case when Name='SouthWest' then sales end) as sw_sales
from
data
group by 
1
),

data_v2 as (
select
a.nw_sales,
b.ca_sales,
c.sw_sales
from
(select nw_sales from tmp_data where nw_sales is not null)a
cross join
(select ca_sales from tmp_data where ca_sales is not null)b
cross join
(select sw_sales from tmp_data where sw_sales is not null)c
)

select * from (
select
nw_sales,
ca_sales,
sw_sales,
nw_sales+ca_sales+sw_sales as total,
rank()over(order by nw_sales+ca_sales+sw_sales desc ) as rnk
from
data_v2
)a
where total<=210000