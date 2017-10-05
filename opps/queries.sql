select owner, 
accountName, 
CloseDate, 
amount, 
sum(amount) over (order by CloseDate rows between unbounded preceding and current row) cumeWon, 
max(amount) over (order by CloseDate rows between unbounded preceding and current row) runningMax
from opportunities 
where stageName='ClosedWon' 
and closeDate >= '2016-10-02' and closeDate <= '2016-10-09' 
order by CloseDate;

select owner,  
accountName,  
CloseDate,  
amount,  
sum(amount) over (partition by owner order by CloseDate rows between unbounded preceding and current row) cumeWon,  
max(amount) over (partition by owner order by CloseDate rows between unbounded preceding and current row) runningMax 
from opportunities  
where stageName='ClosedWon' 
and closeDate >= '2016-10-02' and closeDate <= '2016-10-09'  
order by owner, CloseDate;

select owner, 
wonCount, 
rank() over (order by wonCount desc) rank 
from (
  select owner, 
  count(*) wonCount 
  from opportunities 
  where stageName='ClosedWon' 
  and closeDate >= '2016-10-01' and closeDate < '2016-12-31'  
  group by owner
) t
order by rank;

select a.year, 
a.quarter, 
f.accountName firstAccountName, 
f.owner firstOwner, 
f.amount firstAmount, 
l.accountName lastAccountName, 
l.owner lastOwner, 
l.amount lastAmount 
from (
  select year, 
  quarter, 
  min(firstId) firstId, 
  min(lastId) lastId 
  from (
    select year(closeDate) year, 
    quarter(closeDate) quarter, 
    first_value(id) over (partition by year(closeDate), quarter(closeDate) order by closeDate rows between unbounded preceding and current row) firstId, 
    last_value(id) over (partition by year(closeDate), quarter(closeDate) order by closeDate rows between current row and unbounded following) lastId 
    from opportunities  where stageName='ClosedWon'
  ) t 
  group by year, quarter order by year,quarter
) a 
join opportunities f on a.firstId = f.id 
join opportunities l on a.lastId = l.id 
order by year, quarter;

select accountName, 
closeDate,  
amount currentOppAmount, 
lag(amount) over (partition by accountName order by closeDate) priorAmount, lead(amount) over (partition by accountName order by closeDate) nextAmount 
from opportunities 
order by accountName, closeDate 
limit 9;

select t.quartile, 
min(t.amount) min, 
max(t.amount) max 
from (
  select amount, 
  ntile(4) over (order by amount asc) quartile 
  from opportunities 
  where closeDate >= '2016-10-01' and closeDate <= '2016-12-31'
  ) t 
group by quartile 
order by quartile;
