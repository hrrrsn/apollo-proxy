FROM node:22.12.0-slim@sha256:f6914c8412c2a7bba8aa751e9a2882614e7fa76b3367cde2a051a45991704377
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
