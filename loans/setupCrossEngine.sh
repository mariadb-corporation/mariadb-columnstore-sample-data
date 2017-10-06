#!/bin/sh
MCS_DIR=/usr/local/mariadb/columnstore

$MCS_DIR/bin/setConfig CrossEngineSupport Host 127.0.0.1
$MCS_DIR/bin/setConfig CrossEngineSupport Port 3306
$MCS_DIR/bin/setConfig CrossEngineSupport User root
$MCS_DIR/bin/setConfig CrossEngineSupport Password ""
