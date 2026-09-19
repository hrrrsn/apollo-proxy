FROM node:24.21.0-slim@sha256:a9d7043680f11d1229c0db1900b7f916719b1f0e4b47ed14a8c881e99767b8d2
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
