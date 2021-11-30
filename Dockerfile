FROM bitnami/node:16.13.0 AS build-step

WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./

RUN npm run build

FROM bitnami/nginx:latest 
COPY --from=build-step /usr/src/app/build /app
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
