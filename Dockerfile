FROM bitnami/node:16.13.0 AS build-step

ARG REACT_APP_SERVICES_HOST=/services/m

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install --production
COPY . ./

RUN npm run build

FROM nginx:1.21.0-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-step /app/build /usr/share/nginx/html
