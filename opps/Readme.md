# Opportunities Data Sample
This data set utilizes a simple sales opportunity table along with randomized data. It is used to illustrate window functions in the [MariaDB ColumnStore knowledge base](https://mariadb.com/kb/en/library/columnstore-window-functions/)

A script is run which will create the table in the test database and load the test data:
```sh
$ ./create_opps_tab.sh
```
After this the queries can run, for example:
```sh
$ mcsmysql -vvv test < queries.sql
```
