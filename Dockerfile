FROM node:22.16.0-slim@sha256:2c87586c21f957842cb1ef20f9f1ca84f32fdffb31d71123c5725496157001c8
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
