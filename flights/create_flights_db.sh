#!/bin/sh
MCS_DIR=/usr/local/mariadb/columnstore
SCHEMA_DIR=$(readlink -f ./schema)

# create flights database (dropping if exists) with 3 columnstore tables: flights, airports, airlines
$MCS_DIR/mysql/bin/mysql --defaults-file=$MCS_DIR/mysql/my.cnf -u root -vvv < $SCHEMA_DIR/schema.sql

# load data into dimension tables airports and airlines.
$MCS_DIR/bin/cpimport -m 2 -s ',' -E '"' flights airports -l $SCHEMA_DIR/airports.csv
$MCS_DIR/bin/cpimport -m 2 -s ',' -E '"' flights airlines -l $SCHEMA_DIR/airlines.csv