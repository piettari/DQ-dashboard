{{ config(materialized='table')
 }}

{% set metrics = [1,2,3,4,5,6,7,8,9,10,11,14,15,16,17,18,19,20,21,22,23] %}
{% set metrics2 = [2,3,4,5,6,7,8,9,10,11,14,15,16,17,18,19,20,21,22,23] -%}

-- из полей вида 03.sep и сентябрь 2023 составляем правильную дату
-- По каждой метрике (через цифру) создаем представление исправленная дата+значение, сортировка по дате

with

{% for fig in metrics -%}
t{{ fig }} as (
    select 
        cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as datetime) as new_date,
        COALESCE(nullIf(DATA, ''), '0') as "{{ fig }}"
    from {{source('DQ', 'zameri2')}}
    where source == '{{ fig }}'
    order by 1)
    {%- if not loop.last -%}, {% endif %}  
    {% endfor %}
    
--
-- джоиним по дате все метрики (заголовки полей вида t2.2, t5.5)

select 
    t1.new_date, t1."1", {% for fig in metrics2 -%}t{{ fig }}."{{ fig }}"
    {%- if not loop.last -%}, {% endif %} {% endfor %}
from t1
{% for fig in metrics2 %} 
left join t{{ fig }} on t1.new_date = t{{ fig }}.new_date{% endfor %} 