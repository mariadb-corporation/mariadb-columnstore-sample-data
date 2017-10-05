select a.airline, 
ad.airport,
count(*) volume,
avg(arr_delay) avg_arrival_delay
from flights f 
join airlines a on f.carrier = a.iata_code 
join airports ad on f.dest= ad.iata_code
where ad.state = 'CA'
and f.year = 2016
group by 1,2
order by 1,2;