#!/bin/bash
# check for argument, if so use as wildcard for file load match, otherwise load everything

LEGACY=/usr/local/mariadb/columnstore

if test -f "$LEGACY"
then
    CPIMPORT=$LEGACY/bin/cpimport
    MARIADB=$LEGACY/mysql/bin/mysql --defaults-file=$LEGACY/mysql/my.cnf
else
    CPIMPORT=/usr/bin/cpimport
    MARIADB=/usr/bin/mysql
fi

DATA_DIR=$(readlink -f ./data)

filematch="*"
if [ $# -eq 1 ]
then
  filematch="*$1*"
fi

# load the specified files under the data directory with the file pattern match
# here we use cpimport mode 2 to force processing at each PM node which has
# the advantage of this being runnable as a regular user with a root installation.
for f in $DATA_DIR/$filematch.csv; do
  echo $f
  $CPIMPORT -m2 -s ',' -E '"' bts flights -l $f
done
