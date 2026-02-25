FROM node:24.14.0-slim@sha256:5f5788dfb37df047dddb2e5a6d7544d2fcc994408284518e6fc31edf5233585a
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
