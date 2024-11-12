FROM node:22.11.0-slim@sha256:9fb260645c03d7d9ed0b50ac42434b0924c66cdc1869307512ae866cd929bd2c
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN rm -rf /app/certificates/* /app/test/ /app/old/

ENV WEB_SERVER_PORT=8080
ENV PROXY_PORT=8443

EXPOSE 8080
EXPOSE 8443

CMD [ "node", "apollo-proxy.js" ]
