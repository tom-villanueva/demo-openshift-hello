FROM bitnami/node:16.13.0 AS build-step

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install --production
COPY . ./

RUN npm run build

FROM nginx:1.21.0-alpine
COPY --from=build-step /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
