FROM node:22.20.0-slim@sha256:2bebe635148edd10bc62b95e7339aad3c9c1c712a6fd7646185f53ea9cc308c9
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
