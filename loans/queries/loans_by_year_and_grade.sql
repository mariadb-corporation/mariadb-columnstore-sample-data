#
# Query total loan amount by year and grade.
# Note the contact on d.year is a hack to make sqlpad to treat this like a string rather than a numberic for visualization
#
select concat(d.year, '-') year,
l.grade, 
sum(l.loan_amnt) total_loans
from loanstats l
join time_d d on d.issue_d = l.issue_d
group by d.year,l.grade
order by d.year,l.grade;