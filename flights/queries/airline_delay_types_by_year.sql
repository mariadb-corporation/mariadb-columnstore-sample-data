select a.airline,
f.year,
"Airline Delay" delay_type,
count(*) delay
from flights f
join airlines a on f.carrier = a.iata_code
where f.carrier_delay > 0
group by a.airline,f.year
union all
select a.airline,
f.year,
"Late Aircraft Delay" delay_type,
count(*) delay
from flights f
join airlines a on f.carrier = a.iata_code
where f.late_aircraft_delay > 0
group by a.airline,f.year
union all
select a.airline,
f.year,
"Air System Delay" delay_type,
count(*) delay
from flights f
join airlines a on f.carrier = a.iata_code
where f.nas_delay > 0
group by a.airline,f.year
union all
select a.airline,
f.year,
"Weather Delay" delay_type,
count(*) delay
from flights f
join airlines a on f.carrier = a.iata_code
where f.weather_delay > 0
group by a.airline,f.year
order by 1,2,3
    