FROM node:22.9.0-slim@sha256:713d770035d11331e61cb2cde6c50520281be5fe5dc69a6e98dec1b4b4a2b050
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
