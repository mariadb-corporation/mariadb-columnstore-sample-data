#!/bin/bash
MCS_DIR=/usr/local/mariadb/columnstore

sudo $MCS_DIR/bin/setConfig CrossEngineSupport Host 127.0.0.1
sudo $MCS_DIR/bin/setConfig CrossEngineSupport Port 3306
sudo $MCS_DIR/bin/setConfig CrossEngineSupport User root
sudo $MCS_DIR/bin/setConfig CrossEngineSupport Password ""
