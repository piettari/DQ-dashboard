{{ config(materialized='table',
          drop_if_exists=true) 
}}



{%- set action_metric_dict = {"16_contSale": "Количество контакт-продаж за день", 
"17_contClean": "Количество чистых контактов за день", 
"18_zamer": "Количество замеров за день", 
"19_viezdPlusDop": "Количество замеров и дополнительных замеров",
"20_viezdDop": "Количество дополнительных выездов",
"21_dogovorAccept": "Количество договоров акцепт"} -%}

{%- set lead_metric_dict = {'2_leadWithoutOffline':'Лиды за день без оффлайн звонков', 
'3_leadYaDirect':'Лиды из Яндекс Директа', 
'4_leadOrganic':'Лиды по органике', 
'5_leadOrganicYa':'Лиды по органике Яндекс', 
'6_leadOrganicGoo':'Лиды по органике Google', 
'7_leadEmail':'Лиды по email', 
'8_leadDirect':'Лиды по прямым заходам', 
'9_leadPartners':'Лиды по партнёрке за исключением крупного клиента', 
'10_leadGeoservice':'Лиды за день по геосервисам', 
'11_leadReferalas':'Лиды по реферальному трафику', 
'14_leadCallBack':'Лиды по колбекам и пулу нехвативших номеров', 
'15_leadYaMap':'Лиды по платным картам Яндекса', 
'23_leadBigClient':'Лиды по крупному клиенту'} -%}

{%- set finance_metric_dict = {"1_adcostWithTax": "Расход с НДС", 
"22_dogovorAcceptSum": "Сумма всех договоров за день"} -%}

select __datetime,
concat(
    {% for key, value in action_metric_dict.items() %} if(d.{{key}}_rel_diff>1,'- {{value}} \r\n','')
    {%- if not loop.last -%}, {% endif %}
    {% endfor %}) as wr_action,
concat(    
    {% for key, value in lead_metric_dict.items() %} if(d.{{key}}_rel_diff>1,'- {{value}} \r\n','')
    {%- if not loop.last -%}, {% endif %}
    {% endfor %}) as wr_leads,
concat(
    {% for key, value in finance_metric_dict.items() %} if(d.{{key}}_rel_diff>1,'- {{value}} \r\n','')
    {%- if not loop.last -%}, {% endif %}
    {% endfor %}) as wr_finance
from DQ.4_comparison