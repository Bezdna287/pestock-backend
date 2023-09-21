#!/bin/zsh
mv currentDump/* dumps/eldump.sql.bak

sudo docker exec -t laputabasededatos pg_dumpall -U postgres > currentDump/dump`date +%d%m%Y"_"%H%M%S`.sql
