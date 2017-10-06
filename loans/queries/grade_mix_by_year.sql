#
# Calculates the percentage grade mix by year. 
# This demonstrates use of a window function to provide a total per row.
# Note the contact on d.year is a hack to make sqlpad to treat this like a string rather than a numberic for visualization
#
select  concat(year, '-') year,
grade,
(total/year_total)*100 grade_pct
from (
    select year,
    grade,
    total,
    sum(total) over (partition by year order by year rows between unbounded preceding and unbounded following) year_total
    from (
        select d.year, 
        l.grade,
        count(*) total
        from loanstats l 
        join time_d d on d.issue_d = l.issue_d
        group by 1,2
    ) t
) u
order by 1,2;