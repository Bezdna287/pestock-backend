#!/bin/zsh


# stop all containers
# sudo docker stop $(sudo docker ps -a -q)

# remove all containers
# sudo docker rm $(sudo docker ps -a -q)

# remove all images
# sudo docker rmi $(sudo docker images -q)

cd ~/desarrollo/express/pestock-backend

git pull

sudo docker stop pstock-backend

sudo docker rm pstock-backend

sudo docker rmi pstock-backend

sudo docker build --tag pstock-backend .

sudo docker compose -f docker-compose-ubu.yml -p pstock up -d

sudo docker ps