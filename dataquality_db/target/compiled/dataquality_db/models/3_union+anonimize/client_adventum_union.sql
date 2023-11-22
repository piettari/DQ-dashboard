

with united_raw_data as (
SELECT * from DQ.2_normalize_zameri
union all
select * from DQ.2_extract_superset_constructor )


select * from united_raw_data