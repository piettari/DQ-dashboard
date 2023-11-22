
--Удаление лишних знаков, переименование столбцов, преобразования типов
with t1 as (
select t1.new_date as new_date, 
toInt32(replace(left(t1."1", LENGTH(t1."1")-5), ',', '')) as adcostWithTax,
toInt32(t2."2") as leadWithoutOffline,
toInt32(t3."3") as leadYaDirect,
toInt32(t4."4") as leadOrganic,
toInt32(t5."5") as leadOrganicYa,
toInt32(t6."6") as leadOrganicGoo,
toInt32(t7."7") as leadEmail,
toInt32(t8."8") as leadDirect,
toInt32(t9."9") as leadPartners,
toInt32(IF(t10."10"=='', '0', t10."10")) as leadGeoservice,
toInt32(IF(t11."11"=='', '0', t11."11")) as leadReferal,
toInt32(IF(t14."14"=='', '0', t14."14")) as leadCallBack,
toInt32(t15."15") as leadPayYaMaps, --or Cards?
toInt32(t16."16") as contProdaj,
toInt32(t17."17") as contClear,
toInt32(t18."18") as zamer,
toInt32(t19."19") as viezdPlusDop,
toInt32(t20."20") as viezdDop,
toInt32(t21."21") as dogovorAccept,
toInt32(replace(left(t22."22", LENGTH(t22."22")-5), ',', '')) as dogovorAcceptSum,
toInt32(IF(t23."23"=='', '0', t23."23")) as leadPik
from DQ.join_zameri)
--
select * from t1