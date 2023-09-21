#!/bin/zsh
sudo docker exec -t your-db-container pg_dumpall -c -U postgres > dumps/dump`date +%d%m%Y"_"%H%M%S`.sql

sudo docker stop laputabasededatos

sudo docker rm laputabasededatos