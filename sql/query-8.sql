/* 8. 파트너별 new_install 유저의 funnel 데이터 추출 */
select
        a.partner
    ,   count(distinct a.identity_adid) as acitve_user
    ,   count(distinct case when e.event_name = 'abx:firstopen' then e.identity_adid else null end) as "abx:firstopen_user"
    ,   count(distinct case when e.event_name = 'abx:login' then e.identity_adid else null end) as "abx:login"
    ,   count(distinct case when e.event_name = 'abx:purchase' then e.identity_adid else null end) as "abx:purchase"
from attribution as a
left join event as e
on a.log_id = e.log_id
where a.attribution_type = 0  -- new_install
and partner is not null
group by
        a.partner
order by
        a.partner;