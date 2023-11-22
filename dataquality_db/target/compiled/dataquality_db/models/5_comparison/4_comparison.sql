

with adv as(
    select * 
    from DQ.4_client_datacraft_union
    where source = 'adventumReport'
),


clnt as(select *
    from DQ.4_client_datacraft_union
    where source = 'companyReport'),

widetable as (
    select * 
    from adv as a
    left join clnt as c using __datetime
),-- В подзапросе diff вычисляем абсолютную разность между показателями из отчетов адвентум и клиента, 
-- а также разницу в процентах (относительно показателей из отчёта адвентум) 
diff as (
    select __datetime,
    
    round(abs(c.1_adcostWithTax - 1_adcostWithTax), 2) as 1_adcostWithTax_abs_diff,
    multiIf ((1_adcostWithTax == 0 AND c.1_adcostWithTax == 0), 0, 
             (1_adcostWithTax == 0 AND c.1_adcostWithTax != 0) OR ((1_adcostWithTax != 0 AND c.1_adcostWithTax == 0)), 100,
             (1_adcostWithTax != 0 AND c.1_adcostWithTax != 0), round(abs(100*(c.1_adcostWithTax - 1_adcostWithTax)/1_adcostWithTax), 2)
             , 10000) as 1_adcostWithTax_rel_diff,   
    
    round(abs(c.2_leadWithoutOffline - 2_leadWithoutOffline), 2) as 2_leadWithoutOffline_abs_diff,
    multiIf ((2_leadWithoutOffline == 0 AND c.2_leadWithoutOffline == 0), 0, 
             (2_leadWithoutOffline == 0 AND c.2_leadWithoutOffline != 0) OR ((2_leadWithoutOffline != 0 AND c.2_leadWithoutOffline == 0)), 100,
             (2_leadWithoutOffline != 0 AND c.2_leadWithoutOffline != 0), round(abs(100*(c.2_leadWithoutOffline - 2_leadWithoutOffline)/2_leadWithoutOffline), 2)
             , 10000) as 2_leadWithoutOffline_rel_diff,   
    
    round(abs(c.3_leadYaDirect - 3_leadYaDirect), 2) as 3_leadYaDirect_abs_diff,
    multiIf ((3_leadYaDirect == 0 AND c.3_leadYaDirect == 0), 0, 
             (3_leadYaDirect == 0 AND c.3_leadYaDirect != 0) OR ((3_leadYaDirect != 0 AND c.3_leadYaDirect == 0)), 100,
             (3_leadYaDirect != 0 AND c.3_leadYaDirect != 0), round(abs(100*(c.3_leadYaDirect - 3_leadYaDirect)/3_leadYaDirect), 2)
             , 10000) as 3_leadYaDirect_rel_diff,   
    
    round(abs(c.4_leadOrganic - 4_leadOrganic), 2) as 4_leadOrganic_abs_diff,
    multiIf ((4_leadOrganic == 0 AND c.4_leadOrganic == 0), 0, 
             (4_leadOrganic == 0 AND c.4_leadOrganic != 0) OR ((4_leadOrganic != 0 AND c.4_leadOrganic == 0)), 100,
             (4_leadOrganic != 0 AND c.4_leadOrganic != 0), round(abs(100*(c.4_leadOrganic - 4_leadOrganic)/4_leadOrganic), 2)
             , 10000) as 4_leadOrganic_rel_diff,   
    
    round(abs(c.5_leadOrganicYa - 5_leadOrganicYa), 2) as 5_leadOrganicYa_abs_diff,
    multiIf ((5_leadOrganicYa == 0 AND c.5_leadOrganicYa == 0), 0, 
             (5_leadOrganicYa == 0 AND c.5_leadOrganicYa != 0) OR ((5_leadOrganicYa != 0 AND c.5_leadOrganicYa == 0)), 100,
             (5_leadOrganicYa != 0 AND c.5_leadOrganicYa != 0), round(abs(100*(c.5_leadOrganicYa - 5_leadOrganicYa)/5_leadOrganicYa), 2)
             , 10000) as 5_leadOrganicYa_rel_diff,   
    
    round(abs(c.6_leadOrganicGoo - 6_leadOrganicGoo), 2) as 6_leadOrganicGoo_abs_diff,
    multiIf ((6_leadOrganicGoo == 0 AND c.6_leadOrganicGoo == 0), 0, 
             (6_leadOrganicGoo == 0 AND c.6_leadOrganicGoo != 0) OR ((6_leadOrganicGoo != 0 AND c.6_leadOrganicGoo == 0)), 100,
             (6_leadOrganicGoo != 0 AND c.6_leadOrganicGoo != 0), round(abs(100*(c.6_leadOrganicGoo - 6_leadOrganicGoo)/6_leadOrganicGoo), 2)
             , 10000) as 6_leadOrganicGoo_rel_diff,   
    
    round(abs(c.7_leadEmail - 7_leadEmail), 2) as 7_leadEmail_abs_diff,
    multiIf ((7_leadEmail == 0 AND c.7_leadEmail == 0), 0, 
             (7_leadEmail == 0 AND c.7_leadEmail != 0) OR ((7_leadEmail != 0 AND c.7_leadEmail == 0)), 100,
             (7_leadEmail != 0 AND c.7_leadEmail != 0), round(abs(100*(c.7_leadEmail - 7_leadEmail)/7_leadEmail), 2)
             , 10000) as 7_leadEmail_rel_diff,   
    
    round(abs(c.8_leadDirect - 8_leadDirect), 2) as 8_leadDirect_abs_diff,
    multiIf ((8_leadDirect == 0 AND c.8_leadDirect == 0), 0, 
             (8_leadDirect == 0 AND c.8_leadDirect != 0) OR ((8_leadDirect != 0 AND c.8_leadDirect == 0)), 100,
             (8_leadDirect != 0 AND c.8_leadDirect != 0), round(abs(100*(c.8_leadDirect - 8_leadDirect)/8_leadDirect), 2)
             , 10000) as 8_leadDirect_rel_diff,   
    
    round(abs(c.9_leadPartners - 9_leadPartners), 2) as 9_leadPartners_abs_diff,
    multiIf ((9_leadPartners == 0 AND c.9_leadPartners == 0), 0, 
             (9_leadPartners == 0 AND c.9_leadPartners != 0) OR ((9_leadPartners != 0 AND c.9_leadPartners == 0)), 100,
             (9_leadPartners != 0 AND c.9_leadPartners != 0), round(abs(100*(c.9_leadPartners - 9_leadPartners)/9_leadPartners), 2)
             , 10000) as 9_leadPartners_rel_diff,   
    
    round(abs(c.10_leadGeoservice - 10_leadGeoservice), 2) as 10_leadGeoservice_abs_diff,
    multiIf ((10_leadGeoservice == 0 AND c.10_leadGeoservice == 0), 0, 
             (10_leadGeoservice == 0 AND c.10_leadGeoservice != 0) OR ((10_leadGeoservice != 0 AND c.10_leadGeoservice == 0)), 100,
             (10_leadGeoservice != 0 AND c.10_leadGeoservice != 0), round(abs(100*(c.10_leadGeoservice - 10_leadGeoservice)/10_leadGeoservice), 2)
             , 10000) as 10_leadGeoservice_rel_diff,   
    
    round(abs(c.11_leadReferalas - 11_leadReferalas), 2) as 11_leadReferalas_abs_diff,
    multiIf ((11_leadReferalas == 0 AND c.11_leadReferalas == 0), 0, 
             (11_leadReferalas == 0 AND c.11_leadReferalas != 0) OR ((11_leadReferalas != 0 AND c.11_leadReferalas == 0)), 100,
             (11_leadReferalas != 0 AND c.11_leadReferalas != 0), round(abs(100*(c.11_leadReferalas - 11_leadReferalas)/11_leadReferalas), 2)
             , 10000) as 11_leadReferalas_rel_diff,   
    
    round(abs(c.14_leadCallBack - 14_leadCallBack), 2) as 14_leadCallBack_abs_diff,
    multiIf ((14_leadCallBack == 0 AND c.14_leadCallBack == 0), 0, 
             (14_leadCallBack == 0 AND c.14_leadCallBack != 0) OR ((14_leadCallBack != 0 AND c.14_leadCallBack == 0)), 100,
             (14_leadCallBack != 0 AND c.14_leadCallBack != 0), round(abs(100*(c.14_leadCallBack - 14_leadCallBack)/14_leadCallBack), 2)
             , 10000) as 14_leadCallBack_rel_diff,   
    
    round(abs(c.15_leadYaMap - 15_leadYaMap), 2) as 15_leadYaMap_abs_diff,
    multiIf ((15_leadYaMap == 0 AND c.15_leadYaMap == 0), 0, 
             (15_leadYaMap == 0 AND c.15_leadYaMap != 0) OR ((15_leadYaMap != 0 AND c.15_leadYaMap == 0)), 100,
             (15_leadYaMap != 0 AND c.15_leadYaMap != 0), round(abs(100*(c.15_leadYaMap - 15_leadYaMap)/15_leadYaMap), 2)
             , 10000) as 15_leadYaMap_rel_diff,   
    
    round(abs(c.16_contSale - 16_contSale), 2) as 16_contSale_abs_diff,
    multiIf ((16_contSale == 0 AND c.16_contSale == 0), 0, 
             (16_contSale == 0 AND c.16_contSale != 0) OR ((16_contSale != 0 AND c.16_contSale == 0)), 100,
             (16_contSale != 0 AND c.16_contSale != 0), round(abs(100*(c.16_contSale - 16_contSale)/16_contSale), 2)
             , 10000) as 16_contSale_rel_diff,   
    
    round(abs(c.17_contClean - 17_contClean), 2) as 17_contClean_abs_diff,
    multiIf ((17_contClean == 0 AND c.17_contClean == 0), 0, 
             (17_contClean == 0 AND c.17_contClean != 0) OR ((17_contClean != 0 AND c.17_contClean == 0)), 100,
             (17_contClean != 0 AND c.17_contClean != 0), round(abs(100*(c.17_contClean - 17_contClean)/17_contClean), 2)
             , 10000) as 17_contClean_rel_diff,   
    
    round(abs(c.18_zamer - 18_zamer), 2) as 18_zamer_abs_diff,
    multiIf ((18_zamer == 0 AND c.18_zamer == 0), 0, 
             (18_zamer == 0 AND c.18_zamer != 0) OR ((18_zamer != 0 AND c.18_zamer == 0)), 100,
             (18_zamer != 0 AND c.18_zamer != 0), round(abs(100*(c.18_zamer - 18_zamer)/18_zamer), 2)
             , 10000) as 18_zamer_rel_diff,   
    
    round(abs(c.19_viezdPlusDop - 19_viezdPlusDop), 2) as 19_viezdPlusDop_abs_diff,
    multiIf ((19_viezdPlusDop == 0 AND c.19_viezdPlusDop == 0), 0, 
             (19_viezdPlusDop == 0 AND c.19_viezdPlusDop != 0) OR ((19_viezdPlusDop != 0 AND c.19_viezdPlusDop == 0)), 100,
             (19_viezdPlusDop != 0 AND c.19_viezdPlusDop != 0), round(abs(100*(c.19_viezdPlusDop - 19_viezdPlusDop)/19_viezdPlusDop), 2)
             , 10000) as 19_viezdPlusDop_rel_diff,   
    
    round(abs(c.20_viezdDop - 20_viezdDop), 2) as 20_viezdDop_abs_diff,
    multiIf ((20_viezdDop == 0 AND c.20_viezdDop == 0), 0, 
             (20_viezdDop == 0 AND c.20_viezdDop != 0) OR ((20_viezdDop != 0 AND c.20_viezdDop == 0)), 100,
             (20_viezdDop != 0 AND c.20_viezdDop != 0), round(abs(100*(c.20_viezdDop - 20_viezdDop)/20_viezdDop), 2)
             , 10000) as 20_viezdDop_rel_diff,   
    
    round(abs(c.21_dogovorAccept - 21_dogovorAccept), 2) as 21_dogovorAccept_abs_diff,
    multiIf ((21_dogovorAccept == 0 AND c.21_dogovorAccept == 0), 0, 
             (21_dogovorAccept == 0 AND c.21_dogovorAccept != 0) OR ((21_dogovorAccept != 0 AND c.21_dogovorAccept == 0)), 100,
             (21_dogovorAccept != 0 AND c.21_dogovorAccept != 0), round(abs(100*(c.21_dogovorAccept - 21_dogovorAccept)/21_dogovorAccept), 2)
             , 10000) as 21_dogovorAccept_rel_diff,   
    
    round(abs(c.22_dogovorAcceptSum - 22_dogovorAcceptSum), 2) as 22_dogovorAcceptSum_abs_diff,
    multiIf ((22_dogovorAcceptSum == 0 AND c.22_dogovorAcceptSum == 0), 0, 
             (22_dogovorAcceptSum == 0 AND c.22_dogovorAcceptSum != 0) OR ((22_dogovorAcceptSum != 0 AND c.22_dogovorAcceptSum == 0)), 100,
             (22_dogovorAcceptSum != 0 AND c.22_dogovorAcceptSum != 0), round(abs(100*(c.22_dogovorAcceptSum - 22_dogovorAcceptSum)/22_dogovorAcceptSum), 2)
             , 10000) as 22_dogovorAcceptSum_rel_diff,   
    
    round(abs(c.23_leadBigClient - 23_leadBigClient), 2) as 23_leadBigClient_abs_diff,
    multiIf ((23_leadBigClient == 0 AND c.23_leadBigClient == 0), 0, 
             (23_leadBigClient == 0 AND c.23_leadBigClient != 0) OR ((23_leadBigClient != 0 AND c.23_leadBigClient == 0)), 100,
             (23_leadBigClient != 0 AND c.23_leadBigClient != 0), round(abs(100*(c.23_leadBigClient - 23_leadBigClient)/23_leadBigClient), 2)
             , 10000) as 23_leadBigClient_rel_diff  
    
    from widetable
),

ultraWideTable as (
    select * from 
    widetable as w
    left join diff d using __datetime
),
-- в подзапросе  вычисляем количество метрик отличающихся больше, чем на 1 процент по каждому дню
-- 1) суммарно по всем метрикам 2) по финансовым метрикам 3) по лидам 4) по событиям

warnings as (select __datetime,
    (
        countIf(d.1_adcostWithTax_rel_diff > 1)+ 
        
        countIf(d.2_leadWithoutOffline_rel_diff > 1)+ 
        
        countIf(d.3_leadYaDirect_rel_diff > 1)+ 
        
        countIf(d.4_leadOrganic_rel_diff > 1)+ 
        
        countIf(d.5_leadOrganicYa_rel_diff > 1)+ 
        
        countIf(d.6_leadOrganicGoo_rel_diff > 1)+ 
        
        countIf(d.7_leadEmail_rel_diff > 1)+ 
        
        countIf(d.8_leadDirect_rel_diff > 1)+ 
        
        countIf(d.9_leadPartners_rel_diff > 1)+ 
        
        countIf(d.10_leadGeoservice_rel_diff > 1)+ 
        
        countIf(d.11_leadReferalas_rel_diff > 1)+ 
        
        countIf(d.14_leadCallBack_rel_diff > 1)+ 
        
        countIf(d.15_leadYaMap_rel_diff > 1)+ 
        
        countIf(d.16_contSale_rel_diff > 1)+ 
        
        countIf(d.17_contClean_rel_diff > 1)+ 
        
        countIf(d.18_zamer_rel_diff > 1)+ 
        
        countIf(d.19_viezdPlusDop_rel_diff > 1)+ 
        
        countIf(d.20_viezdDop_rel_diff > 1)+ 
        
        countIf(d.21_dogovorAccept_rel_diff > 1)+ 
        
        countIf(d.22_dogovorAcceptSum_rel_diff > 1)+ 
        
        countIf(d.23_leadBigClient_rel_diff > 1)
        ) as all_problems, 

    (   countIf(d.1_adcostWithTax_rel_diff > 1) + 
        countIf(d.22_dogovorAcceptSum_rel_diff > 1)) as finance_problems,

    (
        countIf(d.2_leadWithoutOffline_rel_diff > 1)+ 
        
        countIf(d.3_leadYaDirect_rel_diff > 1)+ 
        
        countIf(d.4_leadOrganic_rel_diff > 1)+ 
        
        countIf(d.5_leadOrganicYa_rel_diff > 1)+ 
        
        countIf(d.6_leadOrganicGoo_rel_diff > 1)+ 
        
        countIf(d.7_leadEmail_rel_diff > 1)+ 
        
        countIf(d.8_leadDirect_rel_diff > 1)+ 
        
        countIf(d.9_leadPartners_rel_diff > 1)+ 
        
        countIf(d.10_leadGeoservice_rel_diff > 1)+ 
        
        countIf(d.11_leadReferalas_rel_diff > 1)+ 
        
        countIf(d.14_leadCallBack_rel_diff > 1)+ 
        
        countIf(d.15_leadYaMap_rel_diff > 1)+ 
        
        countIf(d.23_leadBigClient_rel_diff > 1)
        ) as lead_problems,

    (
        countIf(d.16_contSale_rel_diff > 1)+ 
        
        countIf(d.17_contClean_rel_diff > 1)+ 
        
        countIf(d.18_zamer_rel_diff > 1)+ 
        
        countIf(d.19_viezdPlusDop_rel_diff > 1)+ 
        
        countIf(d.20_viezdDop_rel_diff > 1)+ 
        
        countIf(d.21_dogovorAccept_rel_diff > 1)
        ) as action_problems
from ultraWideTable
group by __datetime),

-- В diff_metric_names выводим имена метрик, которые расходятся при помощи словарей с названиями

diff_metric_names as (select __datetime,
concat(
     if(d.16_contSale_rel_diff>1,'- Количество контакт-продаж за день \r\n',''), 
     if(d.17_contClean_rel_diff>1,'- Количество чистых контактов за день \r\n',''), 
     if(d.18_zamer_rel_diff>1,'- Количество замеров за день \r\n',''), 
     if(d.19_viezdPlusDop_rel_diff>1,'- Количество замеров и дополнительных замеров \r\n',''), 
     if(d.20_viezdDop_rel_diff>1,'- Количество дополнительных выездов \r\n',''), 
     if(d.21_dogovorAccept_rel_diff>1,'- Количество договоров акцепт \r\n','')
    ) as wr_action,
concat(    
     if(d.2_leadWithoutOffline_rel_diff>1,'- Лиды за день без оффлайн звонков \r\n',''), 
     if(d.3_leadYaDirect_rel_diff>1,'- Лиды из Яндекс Директа \r\n',''), 
     if(d.4_leadOrganic_rel_diff>1,'- Лиды по органике \r\n',''), 
     if(d.5_leadOrganicYa_rel_diff>1,'- Лиды по органике Яндекс \r\n',''), 
     if(d.6_leadOrganicGoo_rel_diff>1,'- Лиды по органике Google \r\n',''), 
     if(d.7_leadEmail_rel_diff>1,'- Лиды по email \r\n',''), 
     if(d.8_leadDirect_rel_diff>1,'- Лиды по прямым заходам \r\n',''), 
     if(d.9_leadPartners_rel_diff>1,'- Лиды по партнёрке за исключением крупного клиента \r\n',''), 
     if(d.10_leadGeoservice_rel_diff>1,'- Лиды за день по геосервисам \r\n',''), 
     if(d.11_leadReferalas_rel_diff>1,'- Лиды по реферальному трафику \r\n',''), 
     if(d.14_leadCallBack_rel_diff>1,'- Лиды по колбекам и пулу нехвативших номеров \r\n',''), 
     if(d.15_leadYaMap_rel_diff>1,'- Лиды по платным картам Яндекса \r\n',''), 
     if(d.23_leadBigClient_rel_diff>1,'- Лиды по крупному клиенту \r\n','')
    ) as wr_leads,
concat(
     if(d.1_adcostWithTax_rel_diff>1,'- Расход с НДС \r\n',''), 
     if(d.22_dogovorAcceptSum_rel_diff>1,'- Сумма всех договоров за день \r\n','')
    ) as wr_finance
from ultraWideTable
),

pretable as (
    select * 
    from ultraWideTable
    left join diff_metric_names using __datetime
),

final_table as (
    select * 
    from pretable 
    left join warnings using __datetime 
)

select * from final_table