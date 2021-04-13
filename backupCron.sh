#!/bin/bash
# ----------------------------------------------------- #
# BackupCron: Runs crontab to backup data
# ----------------------------------------------------- #

cd "$(crontab -l | cut -d " " -f 7)"
./src/backupNow.sh