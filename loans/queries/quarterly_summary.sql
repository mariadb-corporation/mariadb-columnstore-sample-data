#
# Query sum, average, and count of loan amounts by quarter since the start of 2014. 
# Query illustrates performance due to:
# - Small number of columns referenced compared to total table column count.
# - aggregations and filtering
# - cross engine join with time_d dimension table.
#
select t.yrqtr, 
sum(l.loan_amnt) total_loan_amnt,
avg(l.loan_amnt) avg_loan_amnt,
count(*) count 
from loanstats l
join time_d t on l.issue_d = t.issue_d
where t.year >= 2014
group by t.yrqtr 
order by t.yrqtr;


