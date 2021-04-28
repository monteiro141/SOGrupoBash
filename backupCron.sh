#!/bin/bash
# ----------------------------------------------------- #
# BackupCron: Runs crontab to backup data
# ----------------------------------------------------- #


cd "$(crontab -l | cut -d " " -f 7)"

#read default variables from the config file
. ./src/readConfig.sh

<<<<<<< HEAD
. ./src/backupNowCron.sh
=======
cd "$(crontab -l | cut -d " " -f 7)"
. ./src/backupNow.sh
>>>>>>> f491295eb7758716a957da2da4cec9aa0a5bb1ed
