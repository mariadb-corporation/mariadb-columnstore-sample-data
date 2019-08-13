select dest,
month,
monthname(concat("2018/", month, "/01")) month_name,
day,
avg(arr_delay),
max(arr_delay)
from flights
where dest in ('SFO', 'OAK')
and arr_delay > 0
and month = 11
and year = 2018
group by 1,2,3,4
order by 1,2,4;
