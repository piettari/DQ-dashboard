
--Удаление лишних знаков, переименование столбцов, преобразования типов
with t1 as (
select t1.new_date as __datetime, 
toInt32(replace(left(t1."1", LENGTH(t1."1")-5), ',', '')) as  1_adcostWithTax ,
toInt32(t2."2") as 2_leadWithoutOffline,
toInt32(t3."3") as 3_leadYaDirect,
toInt32(t4."4") as 4_leadOrganic,
toInt32(t5."5") as 5_leadOrganicYa,
toInt32(t6."6") as 6_leadOrganicGoo,
toInt32(t7."7") as 7_leadEmail,
toInt32(t8."8") as 8_leadDirect,
toInt32(t9."9") as 9_leadPartners,
toInt32(IF(t10."10"=='', '0', t10."10")) as 10_leadGeoservice,
toInt32(IF(t11."11"=='', '0', t11."11")) as 11_leadReferalas,
toInt32(IF(t14."14"=='', '0', t14."14")) as 14_leadCallBack,
toInt32(t15."15") as 15_leadYaMap, --or Cards?
toInt32(t16."16") as 16_contSale,
toInt32(t17."17") as 17_contClean,
toInt32(t18."18") as 18_zamer,
toInt32(t19."19") as 19_viezdPlusDop,
toInt32(t20."20") as 20_viezdDop,
toInt32(t21."21") as 21_dogovorAccept,
toInt32(replace(left(t22."22", LENGTH(t22."22")-5), ',', '')) as 22_dogovorAcceptSum,
toInt32(IF(t23."23"=='', '0', t23."23")) as 23_leadBigClient
from DQ.1_join_zameri)
--
select *, 'companyReport' as source 
from t1