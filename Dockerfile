# syntax=docker/dockerfile:1

# Create Python environment and install dependencies:
FROM python:3.11.0-slim-buster as build

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"


COPY requirements.txt .
RUN pip install -r requirements.txt

# NODE app:

FROM node:18.17.1

ENV NODE_ENV=production

WORKDIR /app

COPY --from=build /opt/venv /venv

ENV PATH="/venv/bin:$PATH"

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --production

COPY . .

CMD [ "npm", "run", "serve" ]

EXPOSE 3001