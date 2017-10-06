use loans;

drop table if exists time_d;

create table time_d (
  issue_d char(8) primary key not null,
  issue_date date unique key not null,
  year smallint(4) not null,
  quarter tinyint(1) not null,
  yrqtr char(6) not null,
  month varchar(9) not null
) engine=innodb;

insert into time_d (issue_d, issue_date, year, quarter, yrqtr, month)
select issue_d,
issue_date,
year(issue_date) year,
quarter(issue_date) quarter,
concat(year(issue_date), '-', quarter(issue_date)) yrqtr, 
monthname(issue_date) month
from
( select distinct issue_d, 
  str_to_date(concat('01-', issue_d), '%d-%b-%Y') issue_date 
  from loanstats
) t order by issue_date;

