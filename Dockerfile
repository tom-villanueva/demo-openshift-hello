FROM bitnami/node:16.13.0 AS builder
ENV NODE_ENV production
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm i --production
COPY . ./
RUN npm run build

FROM bitnami/nginx:latest AS production
ENV NODE_ENV production
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]