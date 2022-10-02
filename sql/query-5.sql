/* 5. 캠페인별 구매 금액 추출 */
select
        a.campaign
    ,   count(distinct a.identity_adid) as acitve_user
    ,   coalesce(sum(e.price), 0) as amount
from attribution as a
left join event as e
on a.log_id = e.log_id
group by
        a.campaign
order by
        a.campaign;