FROM node:24.11.1-slim@sha256:faeceb0f73551bad0ca8ac8a4bab395f610d2b53edc797f5716c707ba91b1334
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
