FROM node:22.9.0-slim@sha256:7f954a6c513522ed67a3bbd7bc702b31b14fa7ebcdaeb3c8873db9dd3659c043
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
