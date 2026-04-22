FROM node:24.15.0-slim@sha256:dad1a61d4421f0e72068d9f864c73c1e2a617e2cdb23edc777dbc6fe2c90e720
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
