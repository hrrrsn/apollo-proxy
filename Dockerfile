FROM node:22.13.1-slim@sha256:a6c1e4f981da98dd84e22fc5233b43f7c49d193abfa116ed8ccdf1f13843c070
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
