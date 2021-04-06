#!/bin/bash
cd "$(crontab -l | cut -d " " -f 7)"
./backupNow.sh