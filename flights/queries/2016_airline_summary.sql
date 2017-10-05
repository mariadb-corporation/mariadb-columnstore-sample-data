select 
q.airline,
q.volume flight_count,
round(100 * q.volume / sum(q.volume) over (order by q.airline rows between unbounded preceding and unbounded following),2) market_share_pct,
round(100 * (q.cancelled / q.volume), 2) cancelled_pct,
round(100 * (q.diverted / q.volume), 2) diverted_pct
from (
    select a.airline, 
    count(*) volume, 
    sum(diverted) diverted, 
    sum(cancelled) cancelled 
    from flights f 
    join airlines a on f.carrier = a.iata_code 
    where f.year = 2016
    group by a.airline
) q
order by flight_count desc;
