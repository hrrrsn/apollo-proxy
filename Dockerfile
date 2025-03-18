FROM node:22.14.0-slim@sha256:bac8ff0b5302b06924a5e288fb4ceecef9c8bb0bb92515985d2efdc3a2447052
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
