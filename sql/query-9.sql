with
retention_interval(index_name, interval_date) as (
        values
            ('D+0', 0)
        ,   ('D+1', 1)
        ,   ('D+2', 2)
        ,   ('D+3', 3)
        ,   ('D+3', 7)
), mst_users as (
    select
            identity_adid
        ,   min(date) as first_open
    from event
    where event_name = 'abx:firstopen'
    group by identity_adid
), action_log_with_mst_users as (
    select
            u.identity_adid
        ,   u.first_open
        ,   e.date as action_date
        ,   r.index_name
        ,   date_add('day', r.interval_date, u.first_open) as index_date
    from mst_users as u
    left join event as e
    on u.identity_adid = e.identity_adid
    cross join retention_interval as r
), user_aciton_flag as (
    select
            identity_adid
        ,   first_open
        ,   index_name
        ,   sign(sum(case when index_date = action_date then 1 else 0 end)) as index_date_action
    from action_log_with_mst_users
    group by
            identity_adid, first_open, index_name, index_date
)
select
        first_open
    ,   count(distinct identity_adid) as "firstopen_day"
    ,   sum(case when index_name = 'D+0' then index_date_action else 0 end) as "D+0"
    ,   sum(case when index_name = 'D+1' then index_date_action else 0 end) as "D+1"
    ,   sum(case when index_name = 'D+2' then index_date_action else 0 end) as "D+2"
    ,   sum(case when index_name = 'D+3' then index_date_action else 0 end) as "D+3"
    ,   sum(case when index_name = 'D+7' then index_date_action else 0 end) as "D+7"
from user_aciton_flag
group by first_open
order by first_open;