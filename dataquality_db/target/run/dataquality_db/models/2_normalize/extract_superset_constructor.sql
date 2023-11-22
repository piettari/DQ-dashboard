
  
    
    
        
        insert into DQ.extract_superset_constructor ("__datetime", "round(sum(adcost), 0)", "source")
  

with superset_table as (
select __datetime,
round(sum(adcost), 0) 
from DQ.superset_konstructor
where accountName == 'fabrikaokonadventum'
group by __datetime
order by 1
)



select *, 'superset' as source
from superset_table
  