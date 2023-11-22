
  
    
    
        
        insert into DQ.4_client_datacraft_union__dbt_backup ("__datetime", "1_adcostWithTax", "2_leadWithoutOffline", "3_leadYaDirect", "4_leadOrganic", "5_leadOrganicYa", "6_leadOrganicGoo", "7_leadEmail", "8_leadDirect", "9_leadPartners", "10_leadGeoservice", "11_leadReferalas", "14_leadCallBack", "15_leadYaMap", "16_contSale", "17_contClean", "18_zamer", "19_viezdPlusDop", "20_viezdDop", "21_dogovorAccept", "22_dogovorAcceptSum", "23_leadBigClient", "source")
  

with united_raw_data as (
select * from DQ.3_client_anonimize
union all
select * from DQ.3_datacraft_anonimize )


select * from united_raw_data
  