#!/bin/zsh

mv currentDump/* dumps/eldump.sql.bak

sudo docker exec -t laputabasededatos pg_dumpall -U postgres > currentDump/dump`date +%d%m%Y"_"%H%M%S`.sql

python fix.py

sudo docker stop laputabasededatos

sudo docker stop laputabasededatos

# must have dumped BD before removing container, data will be lost
sudo docker rm laputabasededatos

# stop all containers
sudo docker stop pstock-frontend
sudo docker stop pstock-backend

# remove all containers 
sudo docker rm pstock-frontend
sudo docker rm pstock-backend

# remove all images
sudo docker rmi pstock-frontend
sudo docker rmi pstock-backend

