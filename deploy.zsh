#!/bin/zsh


# stop all containers
# sudo docker stop $(sudo docker ps -a -q)

# remove all containers
# sudo docker rm $(sudo docker ps -a -q)

# remove all images
# sudo docker rmi $(sudo docker images -q)

cd ~/desarrollo/angular/eseoshe

rm -rf dist/*

npm run build

sudo docker build --tag pstock-frontend .

cd ~/desarrollo/express/pestock-backend

sudo docker build --tag pstock-backend .

sudo docker compose -f docker-compose-ubu.yml -p pstock up -d

sudo docker ps