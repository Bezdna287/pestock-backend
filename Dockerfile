# syntax=docker/dockerfile:1

FROM node:18.17.1

ENV NODE_ENV=production

WORKDIR /app

RUN apt-get update

RUN apt-get install -y python3-pip
COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --production

COPY . .



CMD [ "npm", "run", "serve" ]

EXPOSE 3001