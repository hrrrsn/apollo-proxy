FROM node:24.13.0-slim@sha256:12cdbb6b2b9d4616eb1f6146ce4902fba7cef72ab972285b48e4b355e838460d
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
