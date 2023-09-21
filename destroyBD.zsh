#!/bin/zsh
mv currentDump/* dumps/eldump.sql.bak

sudo docker exec -t laputabasededatos pg_dumpall -c -U postgres > currentDump/dump`date +%d%m%Y"_"%H%M%S`.sql

sudo docker stop laputabasededatos

sudo docker rm laputabasededatos