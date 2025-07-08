FROM node:22.17.0-slim@sha256:60477e3a90a949ae311fd04134a761e81a7c16203ee6647c7d54b3988c1a1aad
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
