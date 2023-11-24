{{ config(materialized='table',
          drop_if_exists=true) 
}}

with united_raw_data as (

    select * from {{ref('3_client_anonimize') }}

union all

    select * from {{ref('3_datacraft_anonimize')}}
)


select * from united_raw_data