{{ config(materialized='table',
          drop_if_exists=true) 
}}

{%- set metric_list = [ '1_adcostWithTax', '2_leadWithoutOffline', '3_leadYaDirect', '4_leadOrganic', '5_leadOrganicYa', '6_leadOrganicGoo', '7_leadEmail', '8_leadDirect', '9_leadPartners', '10_leadGeoservice', '11_leadReferalas', '14_leadCallBack', '15_leadYaMap', '16_contSale', '17_contClean', '18_zamer', '19_viezdPlusDop', '20_viezdDop','21_dogovorAccept', '22_dogovorAcceptSum', '23_leadBigClient' ] -%}
{%- set lead_metric_list = [ '2_leadWithoutOffline', '3_leadYaDirect', '4_leadOrganic', '5_leadOrganicYa', '6_leadOrganicGoo', '7_leadEmail', '8_leadDirect', '9_leadPartners', '10_leadGeoservice', '11_leadReferalas', '14_leadCallBack', '15_leadYaMap', '23_leadBigClient' ] -%}
{%- set action_metric_list = [ '16_contSale', '17_contClean', '18_zamer', '19_viezdPlusDop', '20_viezdDop','21_dogovorAccept' ] -%}
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

with adv as(

    select *

    from {{ref('4_client_datacraft_union') }}
    where source = 'adventumReport'
),

clnt as(

    select *
    
    from {{ref('4_client_datacraft_union')}}
    where source = 'companyReport'),

widetable as (

    select *

    from adv as a
    left join clnt as c using __datetime
),


-- В подзапросе diff вычисляем абсолютную разность между показателями из отчетов адвентум и клиента, 
-- а также разницу в процентах (относительно показателей из отчёта адвентум) 
diff as (

    select 
        __datetime,
        {% for mn in metric_list %}
        round(abs(c.{{ mn }} - {{ mn }}), 2) as {{ mn }}_abs_diff,
        multiIf (({{ mn }} == 0 AND c.{{ mn }} == 0), 0, 
                ({{ mn }} == 0 AND c.{{ mn }} != 0) OR (({{ mn }} != 0 AND c.{{ mn }} == 0)), 100,
                ({{ mn }} != 0 AND c.{{ mn }} != 0), round(abs(100*(c.{{ mn }} - {{ mn }})/{{ mn }}), 2)
                , 10000) as {{ mn }}_rel_diff
        
        {%- if not loop.last -%}, {% endif %}  
        {% endfor %}

    from widetable
),

ultraWideTable as (

    select * 
    
    from widetable as w
    left join diff d using __datetime
),

-- в подзапросе  вычисляем количество метрик отличающихся больше, чем на 1 процент по каждому дню
-- 1) суммарно по всем метрикам 2) по финансовым метрикам 3) по лидам 4) по событиям

warnings as (
    
    select 
        __datetime,
        ({% for mn in metric_list %}
            countIf(d.{{ mn }}_rel_diff > 1){%- if not loop.last -%} + {% endif %}
            {% endfor %}) as all_problems, 

        (   countIf(d.1_adcostWithTax_rel_diff > 1) + 
            countIf(d.22_dogovorAcceptSum_rel_diff > 1)) as finance_problems,

        ({% for lm in lead_metric_list %}
            countIf(d.{{ lm }}_rel_diff > 1){%- if not loop.last -%} + {% endif %}
            {% endfor %}) as lead_problems,

        ({% for am in action_metric_list %}
            countIf(d.{{ am }}_rel_diff > 1){%- if not loop.last -%} + {% endif %}
            {% endfor %}) as action_problems

    from ultraWideTable
    group by __datetime),

-- В diff_metric_names выводим имена метрик, которые расходятся при помощи словарей с названиями

diff_metric_names as (

    select 
        __datetime,
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