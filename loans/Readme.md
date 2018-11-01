# Loans Data Sample
This utilizes the public data set made available from the company [LendingClub](https://www.lendingclub.com/info/download-data.action). The data set demonstrates cross engine joins and some more complex queries including window functions.

## Retrieve Data
The following script will retrieve the data set files available up to 2017_Q2. If new data sets are available and the script is not updated, it can be tweaked to pull the additional files. As new data is made available it is also possible that the table definition needs to be modified to handle new columns in the data set.
```sh
$ ./get_loans_data.sh
```

After completion a single LoanStats.csv.gz file contains the combined data set gzip compressed.

## Creating and Loading Database
The following script will create (and drop if it already exists) the *loans* database:
```sh
$ ./create_loans_db.sh
```
The script assumes a root install and so utilizes sudo to run the cpimport command.

The following script is a useful helper for setting up cross engine join for a default test install with no root password for the localhost root account:
```sh
$ ./setupCrossEngine.sh
```

## Sample Queries
The following sample queries are provided in the queries directory:

1. **grade_mix_by_year.sql** :  Percentage break down of loans by grade by year
2. **loans_by_year_and_grade.sql** : Summary of loan amounts by year and grade
3. **quarterly_summary.sql** : Simple quarterly summary of loans
4. **top_delinq_amnt_pac.sql** : Top delinquent loan amounts by state limited to the pacific states.
5. **total_loans_over_time.sql** : Total cumulative loan amount by quarter over time.

The queries can be run in your favorite graphical tool (the queries are designed to work well with [sqlpad](https://rickbergfalk.github.io/sqlpad/) but can also be run on the command line, for example:
```sh
$ mcsmysql -vvv loans < queries/total_loans_over_time.sql.sql
```
