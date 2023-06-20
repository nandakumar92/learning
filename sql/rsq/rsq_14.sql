
select
a.ProductModelID,
a.Name,
c.description,
d.name
from
productmodel a
join productmodelproductdescriptionculture b
on a.ProductModelID=b.ProductModelID
join productdescription c
on b.ProductDescriptionID=c.ProductDescriptionID
join culture d
on b.CultureID=d.CultureID
where d.name !='English'