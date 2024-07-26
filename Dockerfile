FROM node:22.5.1-slim@sha256:2fb92fe9d7350866a73c5cc311c1a19919ffd47e8592d4233374ee330e3bdb1e
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
