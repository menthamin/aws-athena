/* 2. 일별 구매 유저 및 구매 금액 추출 */
select
        date
    ,   count(distinct identity_adid) as acitve_user
    ,   sum(price) as amount
from event
where date is not null
group by
        date
order by
        date;