FROM node:22.7.0-slim@sha256:1289f8e0bf3a182990d1d046f8ab2a5d45814f8b40b41963650a42c30c91f39e
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
