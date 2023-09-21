#!/bin/zsh

# stop all containers
sudo docker stop $(sudo docker ps -a -q)

# remove all containers
sudo docker rm $(sudo docker ps -a -q)

# remove all images
sudo docker rmi $(sudo docker images -q)