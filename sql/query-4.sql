/* 4. 캠페인별 User 데이터 추출 */
select
        campaign
    ,   count(distinct identity_adid) as acitve_user
from attribution
group by
        campaign
order by
        campaign;