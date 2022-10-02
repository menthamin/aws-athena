/* 3. 이벤트별 User 데이터 추출 */
-- date is null 사용
select
        event_name
    ,   count(distinct identity_adid) as acitve_user
from event
group by
        event_name
order by
        acitve_user desc;