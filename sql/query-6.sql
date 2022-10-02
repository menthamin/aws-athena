/* 6. 국가, 캠페인별 구매 금액 추출 */
select
        a.campaign
    ,   e.country
    ,   count(distinct a.identity_adid) as acitve_user
    ,   coalesce(sum(e.price), 0) as amount
from attribution as a
left join event as e
on a.log_id = e.log_id
group by
        a.campaign
    ,   e.country
order by
        a.campaign
    ,   e.country;