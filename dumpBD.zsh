#!/bin/zsh
mv currentDump/* dumps/eldump.sql.bak

sudo docker exec -t laputabasededatos pg_dump -c --if-exists -U postgres > currentDump/dump`date +%d%m%Y"_"%H%M%S`.sql
