FROM node:24.14.0-slim@sha256:101e6cd9ad96823fbe088294e4b99c9ef4e689ca5cd989f692e0cac75d902f8f
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
