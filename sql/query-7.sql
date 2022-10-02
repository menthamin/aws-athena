/* 7. Funnel 데이터 추출 */
with
daily_event as (
-- daily_event: daily event aggregation table
select
        date
    ,   event_name
    ,   count(distinct identity_adid) as cnt
from event
group by
        date
    ,   event_name
)
select
        date
    ,   sum(case
                when event_name = 'abx:firstopen' then cnt
                else 0
            end
        ) as "abx:firstopen_user"
    ,   sum(case
                when event_name = 'abx:login' then cnt
                else 0
            end
        ) as "abx:login"
    ,   sum(case
                when event_name = 'abx:purchase' then cnt
                else 0
            end
        ) as "abx:purchase"
from daily_event
group by
        date
order by
        date;