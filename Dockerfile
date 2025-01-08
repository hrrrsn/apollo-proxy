FROM node:22.13.0-slim@sha256:fe64023c6490eb001c7a28e9f92ef8deb6e40e1b7fc5352d695dcaef59e1652d
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
