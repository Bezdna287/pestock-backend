# syntax=docker/dockerfile:1







FROM node:18.17.1
ENV NODE_ENV=production

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN apt-get update
RUN apt-get install --yes python3

# RUN apt-get install --yes pip

# COPY ./requirements.txt /app/requirements.txt
 
# RUN pip install -r /app/requirements.txt

RUN npm install --production

COPY . .

CMD [ "npm", "run", "serve" ]

EXPOSE 3001