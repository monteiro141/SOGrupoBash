#!/bin/bash
# ----------------------------------------------------- #
# BackupCron: Runs crontab to backup data
# ----------------------------------------------------- #

#read default variables from the config file
. ./src/readConfig.sh

cd "$(crontab -l | cut -d " " -f 7)"
./src/backupNow.sh