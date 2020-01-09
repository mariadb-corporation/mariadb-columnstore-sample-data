#!/bin/bash
FOLDER=/usr/local/mariadb/columnstore

if test -f "$FOLDER"
then
    CPIMPORT=$FOLDER/bin/cpimport
    MARIADB=$FOLDER/mysql/bin/mysql --defaults-file=$FOLDER/mysql/my.cnf
else
    CPIMPORT=/usr/bin/cpimport
    MARIADB=/usr/bin/mysql
fi

SCHEMA_DIR=$(readlink -f ./schema)

# create flights database (dropping if exists) with 3 columnstore tables: flights, airports, airlines
$MARIADB -u root -vvv < $SCHEMA_DIR/schema.sql

# load data into dimension tables airports and airlines.
$CPIMPORT -m 2 -s ',' -E '"' flights airports -l $SCHEMA_DIR/airports.csv
$CPIMPORT -m 2 -s ',' -E '"' flights airlines -l $SCHEMA_DIR/airlines.csv
