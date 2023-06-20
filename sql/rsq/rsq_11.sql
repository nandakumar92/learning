

select
c.Name as country,
max(a.TaxRate) as max_tax_rate
from salestaxrate a 
join stateprovince b
on a.StateProvinceID=b.StateProvinceID
join countryregion c
on b.CountryRegionCode=c.CountryRegionCode
group by 
1
