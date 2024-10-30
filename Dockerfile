FROM node:22.11.0-slim@sha256:f73e9c70d4279d5e7b7cc1fe307c5de18b61089ffa2235230408dfb14e2f09a0
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
