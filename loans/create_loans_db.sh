#!/bin/sh
MCS_DIR=/usr/local/mariadb/columnstore
SCHEMA_DIR=$(readlink -f ./schema)

# create loans db and loanstats table
$MCS_DIR/mysql/bin/mysql --defaults-file=$MCS_DIR/mysql/my.cnf -u root -vvv < $SCHEMA_DIR/create_loanstats.sql

# create states_d table
$MCS_DIR/mysql/bin/mysql --defaults-file=$MCS_DIR/mysql/my.cnf -u root -vvv loans < $SCHEMA_DIR/create_states_d.sql

# load states dimension data
$MCS_DIR/mysql/bin/mysql --defaults-file=$MCS_DIR/mysql/my.cnf -u root -vvv --local-infile loans < $SCHEMA_DIR/loadStates.sql

# cpimport loanstats table
zcat LoanStats.csv.gz | sudo $MCS_DIR/bin/cpimport -s ',' -E '"' loans loanstats

# create time_d table from loanstats data
$MCS_DIR/mysql/bin/mysql --defaults-file=$MCS_DIR/mysql/my.cnf -u root -vvv loans < $SCHEMA_DIR/create_time_d.sql

