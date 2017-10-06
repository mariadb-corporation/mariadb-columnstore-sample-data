#
# Query reports on the top ranked delinquent loan amounts (i.e. the past due amount owed)
# for the 5 Pacific states. In the results note that high delinquent amount doesn't 
# necesarily correspond to higher interest rates. Also CA and WA show the tying behavior 
# of the rank function which shows all tied values but then omits the 3rd. row_number would
# show exactly 3 and dense_rank would show ties but also show the 3rd entry.
# Query illustrates:
# - small number of columns referenced compared to table count
# - join with a states_d dimension table to allow querying by census division name.
# - use of the rank() window function to perform an ordered ranking by state
# - filtering the complete results to show top 3 per state.
#
select * from
( select l.addr_state,
  l.delinq_amnt,
  rank() over (partition by l.addr_state order by l.addr_state, l.delinq_amnt desc) rank
  from loanstats l
  join states_d s on l.addr_state = s.abbreviation
  where s.census_division_name = 'Pacific'
) t
where t.rank <= 5;
