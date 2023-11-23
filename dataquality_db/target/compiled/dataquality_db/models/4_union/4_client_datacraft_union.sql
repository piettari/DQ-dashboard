

with united_raw_data as (

    select * from DQ.3_client_anonimize

union all

    select * from DQ.3_datacraft_anonimize
)


select * from united_raw_data