FROM node:22.15.1-slim@sha256:6caa3d9c49ead9ba98f9015c97a2a4a353369b6ae552c33a1464d58f03477319
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
