#!/bin/bash
LEGACY=/usr/local/mariadb/columnstore

if test -f "$LEGACY"
then
    CPIMPORT=$LEGACY/bin/cpimport
    MARIADB=$(LEGACY/mysql/bin/mysql --defaults-file=$LEGACY/mysql/my.cnf)
else
    CPIMPORT=/usr/bin/cpimport
    MARIADB=/usr/bin/mysql
fi

SCHEMA_DIR=$(readlink -f ./schema)

# create flights database (dropping if exists) with 3 columnstore tables: flights, airports, airlines
$MARIADB -vvv < $SCHEMA_DIR/schema.sql

# load data into dimension tables airports and airlines.
$CPIMPORT -m 2 -s ',' -E '"' bts airports -l $SCHEMA_DIR/airports.csv
$CPIMPORT -m 2 -s ',' -E '"' bts airlines -l $SCHEMA_DIR/airlines.csv
