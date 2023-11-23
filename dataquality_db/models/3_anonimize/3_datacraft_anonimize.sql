{{ config(materialized='table',
          drop_if_exists=true) 
}}

-- анонимизация по формуле 2x+1

with t1 as (

    select 
        __datetime,
        (2* 1_adcostWithTax ) +1 as  1_adcostWithTax ,
        (2* 2_leadWithoutOffline ) +1 as  2_leadWithoutOffline ,
        (2* 3_leadYaDirect ) +1 as  3_leadYaDirect ,
        (2* 4_leadOrganic ) +1 as  4_leadOrganic ,
        (2* 5_leadOrganicYa ) +1 as  5_leadOrganicYa ,
        (2* 6_leadOrganicGoo ) +1 as  6_leadOrganicGoo ,
        (2* 7_leadEmail ) +1 as  7_leadEmail ,
        (2* 8_leadDirect ) +1 as  8_leadDirect ,
        (2* 9_leadPartners ) +1 as  9_leadPartners ,
        (2* 10_leadGeoservice ) +1 as  10_leadGeoservice ,
        (2* 11_leadReferalas ) +1 as  11_leadReferalas ,
        (2* 14_leadCallBack ) +1 as  14_leadCallBack ,
        (2* 15_leadYaMap ) +1 as  15_leadYaMap ,
        (2* 16_contSale ) +1 as  16_contSale ,
        (2* 17_contClean ) +1 as  17_contClean ,
        (2* 18_zamer ) +1 as  18_zamer ,
        (2* 19_viezdPlusDop ) +1 as  19_viezdPlusDop ,
        (2* 20_viezdDop ) +1 as  20_viezdDop ,
        (2* 21_dogovorAccept ) +1 as  21_dogovorAccept ,
        (2* 22_dogovorAcceptSum ) +1 as  22_dogovorAcceptSum ,
        (2* 23_leadBigClient ) +1 as  23_leadBigClient ,
        source
        
    from {{ref('2_datacraft_normalized') }}
)

select * from t1