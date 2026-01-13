FROM node:24.12.0-slim@sha256:732887b2c52d7251840a19d203afc68a61532b1ff8b5bf3b76efd49ded39e908
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
