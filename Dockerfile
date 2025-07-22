FROM node:22.17.1-slim@sha256:6f2d34dd5210bdad52e4204f56305bd7251cc4f9bcf6a5773ffe6ab2ef83a94d
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
