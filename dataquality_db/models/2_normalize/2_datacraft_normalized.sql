{{ config(materialized='table',
          drop_if_exists=true) 
}}

with t1 as (

    select 
        cast(__datetime as datetime) as __datetime,
        round(sumIf(adcost, accountName == 'fabrikaokonadventum'), 0) as 1_adcostWithTax,
        sumIf(lead, adSourceGroup != '09_Оффлайн') as 2_leadWithoutOffline,
        sumIf(lead, adSourceClean == 'Yandex Direct') as 3_leadYaDirect,
        sumIf(lead, adSourceGroup == '02_Органика') as 4_leadOrganic,
        sumIf(lead, adSourceClean == 'Органика yandex') as 5_leadOrganicYa,
        sumIf(lead, adSourceClean == 'Органика google') as 6_leadOrganicGoo, 
        sumIf(lead, adSourceGroup == '04_Email') as 7_leadEmail, 
        sumIf(lead, adSourceGroup == '08_Прямые заходы') as 8_leadDirect, 
        sumIf(lead, adSourceGroup in 
            ('13_Партнёры Инфопроект (срок)', '13_Партнёры Инфопроект', '13_Партнёры', '13_Реферальные партнёры') 
            and adSourceClean != 'ПИК') as 9_leadPartners, 
        sumIf(lead, adSourceGroup == '03_Геосервисы') as 10_leadGeoservice, 
        sumIf(lead, adSourceGroup == '14_Реферальный') as 11_leadReferalas, 
        sumIf(lead, adSourceGroup in ('10_Callback', '12_Не хватило номеров')) as 14_leadCallBack, 
        sumIf(lead, adSourceClean == 'Yandex Карты (плат)') as 15_leadYaMap, 
        sumIf(cont_prodaj, OneCGroups == 'Окна') as 16_contSale, 
        sumIf(cont_clear,  OneCGroups == 'Окна') as 17_contClean,
        sumIf(zamer, OneCGroups == 'Окна') as 18_zamer, 
        sumIf(viezd, OneCGroups == 'Окна') + sumIf(viezd_s_dop, OneCGroups == 'Окна')  as 19_viezdPlusDop, 
        sumIf(viezd_s_dop, OneCGroups == 'Окна') as 20_viezdDop, 
        sumIf(dogovorAccept, OneCGroups == 'Окна') as 21_dogovorAccept , 
        round(sumIf(dogovorAcceptSum, OneCGroups == 'Окна'), 0) as 22_dogovorAcceptSum, 
        sumIf(lead, adSourceClean = 'ПИК') as 23_leadBigClient,
        'adventumReport' as source

    from {{source('DQ', 'superset_konstructor') }}
    group by __datetime
    order by 1)

select * from t1