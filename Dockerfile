FROM node:22.8.0-slim@sha256:9edc5d9bbd21ae097b88da59ddbf2a9d403413b63c508eadde2cb5abc0e04b95
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
