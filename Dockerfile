FROM bitnami/node:16.13.0 AS build-step

WORKDIR /app

COPY package.json /app
#COPY package-lock.json ./
RUN npm install
COPY . /app

RUN npm run build

FROM bitnami/nginx:latest 
COPY --from=build-step /app/build /usr/share/nginx/html
