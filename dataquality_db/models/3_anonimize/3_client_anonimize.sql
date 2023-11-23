{{ config(materialized='table',
          drop_if_exists=true) 
}}
-- анонимизация данные клиента (в основном заменяем на datacraft)


with 
client as (

    select 
        __datetime,
        toFloat64((2* 1_adcostWithTax )) +1 as  1_adcostWithTax ,
        (2* 11_leadReferalas ) +1 as  11_leadReferalas ,
        (2* 20_viezdDop ) +1 as  20_viezdDop

    from {{ ref('2_client_normalized') }}
),

datacraft as (

    select 
        __datetime,
        2_leadWithoutOffline,
        3_leadYaDirect,
        4_leadOrganic,
        5_leadOrganicYa,
        6_leadOrganicGoo, 
        7_leadEmail, 
        8_leadDirect, 
        9_leadPartners, 
        10_leadGeoservice, 
        14_leadCallBack, 
        15_leadYaMap, 
        16_contSale, 
        17_contClean,
        18_zamer, 
        19_viezdPlusDop, 
        21_dogovorAccept , 
        22_dogovorAcceptSum, 
        23_leadBigClient

    from DQ.2_extract_superset_constructor
),

pretable as (

    select 
        *, 
        'companyReport' as source 
    from client
    left join datacraft using __datetime
)


select 
    __datetime,
    1_adcostWithTax,
    (2*datacraft. 2_leadWithoutOffline ) +1 as  2_leadWithoutOffline ,
    (2*datacraft. 3_leadYaDirect ) +1 as  3_leadYaDirect ,
    (2*datacraft. 4_leadOrganic ) +1 as  4_leadOrganic ,
    (2*datacraft. 5_leadOrganicYa ) +1 as  5_leadOrganicYa ,
    (2*datacraft. 6_leadOrganicGoo ) +1 as  6_leadOrganicGoo ,
    (2*datacraft. 7_leadEmail ) +1 as  7_leadEmail ,
    (2*datacraft. 8_leadDirect ) +1 as  8_leadDirect ,
    (2*datacraft. 9_leadPartners ) +1 as  9_leadPartners ,
    (2*datacraft. 10_leadGeoservice ) +1 as  10_leadGeoservice ,
    11_leadReferalas,
    (2*datacraft. 14_leadCallBack ) +1 as  14_leadCallBack ,
    (2*datacraft. 15_leadYaMap ) +1 as  15_leadYaMap ,
    (2*datacraft. 16_contSale ) +1 as  16_contSale ,
    (2*datacraft. 17_contClean ) +1 as  17_contClean ,
    (2*datacraft. 18_zamer ) +1 as  18_zamer ,
    (2*datacraft. 19_viezdPlusDop ) +1 as  19_viezdPlusDop ,
    20_viezdDop,
    (2*datacraft. 21_dogovorAccept ) +1 as  21_dogovorAccept ,
    (2*datacraft. 22_dogovorAcceptSum ) +1 as  22_dogovorAcceptSum ,
    (2*datacraft. 23_leadBigClient ) +1 as  23_leadBigClient ,
    source
    
from pretable
