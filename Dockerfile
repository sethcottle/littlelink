# Dockerfile
FROM node:16
WORKDIR /usr/src/littlelink
COPY package*.json ./
RUN npm install
COPY . .