FROM node:22.11.0-slim@sha256:4b44c32c9f3118d60977d0dde5f758f63c4f9eac8ddee4275277239ec600950f
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
