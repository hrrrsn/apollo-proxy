FROM node:22.21.0-slim@sha256:564a9eb531f99f537913745fbcce3c6235160fc8c59ce492aad3eb7e746ed905
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
