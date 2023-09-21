#!/bin/zsh
mv currentDump/* dumps/eldump.sql.bak

sudo docker exec -t laputabasededatos pg_dumpall -U postgres > currentDump/dump`date +%d%m%Y"_"%H%M%S`.sql

python fix.py

sudo docker stop laputabasededatos

# must have dumped BD before removing container, data will be lost
sudo docker rm laputabasededatos