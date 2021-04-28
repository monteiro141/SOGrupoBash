#!/bin/bash
# ----------------------------------------------------- #
# BackupCron: Runs crontab to backup data
# ----------------------------------------------------- #


cd "$(crontab -l | cut -d " " -f 7)"

#read default variables from the config file
. ./src/readConfig.sh

. ./src/backupNowCron.sh
