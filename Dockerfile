FROM bitnami/node:16.13.0 AS builder
WORKDIR /usr/src/app
COPY package.json ./
COPY package-lock.json ./
RUN npm i --production
COPY . ./
RUN npm run build

FROM bitnami/nginx:latest AS production
COPY --from=builder /usr/src/app/build /app
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]