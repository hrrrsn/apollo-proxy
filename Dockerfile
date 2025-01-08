FROM node:22.13.0-slim@sha256:7ba0518650546520733653cfc82ffa3874064fa7a89ce49e75b685ae2d8b18dd
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
