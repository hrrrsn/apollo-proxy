FROM node:22.9.0-slim@sha256:4fd4447d2a0b726763799eac6cf2e7eac5b32806af6aea7f3075cb79946140be
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
