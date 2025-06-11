FROM node:22.16.0-slim@sha256:2b6c2d5bcd7c50b7cb3bb803eb58d041799e409054a7b6c1704ce1f57abdc8cb
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
