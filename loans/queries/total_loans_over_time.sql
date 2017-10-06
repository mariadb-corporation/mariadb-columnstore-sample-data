#
# Calculates total cumulative loan amount over time since start.
# Demonstrates use of window functions to calculate cumulative amounts.
# Note that this does not match the published graphs on  lendingclub website as a subset of loans is excluded
# from the public data sets.
#
select yrqtr,
sum(loan_amnt) over (order by yrqtr rows between unbounded preceding and current row) loan_amnt,
sum(count) over (order by yrqtr rows between unbounded preceding and current row) count
from (
  select t.yrqtr, 
  sum(l.loan_amnt) loan_amnt,
  count(*) count  
  from loanstats l
  join time_d t on l.issue_d = t.issue_d
  group by t.yrqtr 
order by t.yrqtr) t;