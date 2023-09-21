#!/bin/zsh

# stop all containers
sudo docker stop $(sudo docker ps -a -q)

# remove all containers except DB
sudo docker rm pstock-frontend
sudo docker rm pstock-backend

# remove all images except DB
sudo docker rmi pstock-frontend
sudo docker rmi pstock-backend

mv currentDump/* dumps/eldump.sql.bak

sudo docker exec -t laputabasededatos pg_dumpall -U postgres > currentDump/dump`date +%d%m%Y"_"%H%M%S`.sql

python fix.py

sudo docker stop laputabasededatos

# must have dumped BD before removing container, data will be lost
sudo docker rm laputabasededatos