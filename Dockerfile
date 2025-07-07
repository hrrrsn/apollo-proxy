FROM node:22.17.0-slim@sha256:9e5dfd12841c03124f91ce37173b92d16eeb7e137cd61197015498d7c544d5b4
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
