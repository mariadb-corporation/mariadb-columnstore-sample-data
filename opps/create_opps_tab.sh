#!/bin/sh
MCS_DIR=/usr/local/mariadb/columnstore
THIS_DIR=$(readlink -f .)

$MCS_DIR/mysql/bin/mysql --defaults-file=$MCS_DIR/mysql/my.cnf -u root -vvv test < schema.sql
$MCS_DIR/bin/cpimport -m 2 -s ',' test opportunities -l $THIS_DIR/mock_opp_data.csv


