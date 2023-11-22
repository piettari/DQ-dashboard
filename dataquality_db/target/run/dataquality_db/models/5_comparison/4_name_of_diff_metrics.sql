
  
    
    
        
        insert into DQ.4_name_of_diff_metrics__dbt_backup ("__datetime", "wr_action", "wr_leads", "wr_finance")
  select __datetime,
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
from DQ.4_comparison
  