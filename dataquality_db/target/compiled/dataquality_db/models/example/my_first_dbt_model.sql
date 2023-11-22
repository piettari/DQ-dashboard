

with
t1 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "1"
from DQ.zameri2
where source == '1'
order by 1),   
t2 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "2"
from DQ.zameri2
where source == '2'
order by 1),   
t3 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "3"
from DQ.zameri2
where source == '3'
order by 1),   
t4 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "4"
from DQ.zameri2
where source == '4'
order by 1),   
t5 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "5"
from DQ.zameri2
where source == '5'
order by 1),   
t6 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "6"
from DQ.zameri2
where source == '6'
order by 1),   
t7 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "7"
from DQ.zameri2
where source == '7'
order by 1),   
t8 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "8"
from DQ.zameri2
where source == '8'
order by 1),   
t9 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "9"
from DQ.zameri2
where source == '9'
order by 1),   
t10 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "10"
from DQ.zameri2
where source == '10'
order by 1),   
t11 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "11"
from DQ.zameri2
where source == '11'
order by 1),   
t14 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "14"
from DQ.zameri2
where source == '14'
order by 1),   
t15 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "15"
from DQ.zameri2
where source == '15'
order by 1),   
t16 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "16"
from DQ.zameri2
where source == '16'
order by 1),   
t17 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "17"
from DQ.zameri2
where source == '17'
order by 1),   
t18 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "18"
from DQ.zameri2
where source == '18'
order by 1),   
t19 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "19"
from DQ.zameri2
where source == '19'
order by 1),   
t20 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "20"
from DQ.zameri2
where source == '20'
order by 1),   
t21 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "21"
from DQ.zameri2
where source == '21'
order by 1),   
t22 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "22"
from DQ.zameri2
where source == '22'
order by 1),   
t23 as (
SELECT cast(parseDateTime(concat(replace(replace(date,'aug','08'), 'sep', '09'), '.', substring(mnth, -4, 4)), '%d.%m.%Y') as date) as new_date,
DATA as "23"
from DQ.zameri2
where source == '23'
order by 1)  


select t1.new_date, t1."1", t2."2",  t3."3",  t4."4",  t5."5",  t6."6",  t7."7",  t8."8",  t9."9",  t10."10",  t11."11",  t14."14",  t15."15",  t16."16",  t17."17",  t18."18",  t19."19",  t20."20",  t21."21",  t22."22",  t23."23" 
from t1
 
left join t2 on t1.new_date=t2.new_date 
left join t3 on t1.new_date=t3.new_date 
left join t4 on t1.new_date=t4.new_date 
left join t5 on t1.new_date=t5.new_date 
left join t6 on t1.new_date=t6.new_date 
left join t7 on t1.new_date=t7.new_date 
left join t8 on t1.new_date=t8.new_date 
left join t9 on t1.new_date=t9.new_date 
left join t10 on t1.new_date=t10.new_date 
left join t11 on t1.new_date=t11.new_date 
left join t14 on t1.new_date=t14.new_date 
left join t15 on t1.new_date=t15.new_date 
left join t16 on t1.new_date=t16.new_date 
left join t17 on t1.new_date=t17.new_date 
left join t18 on t1.new_date=t18.new_date 
left join t19 on t1.new_date=t19.new_date 
left join t20 on t1.new_date=t20.new_date 
left join t21 on t1.new_date=t21.new_date 
left join t22 on t1.new_date=t22.new_date 
left join t23 on t1.new_date=t23.new_date