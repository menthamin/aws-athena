/* 1. 일별 Active User 데이터 추출 */
select
        date
    ,   count(distinct identity_adid) as acitve_user
from event
where date is not null
group by
        date
order by
        date;