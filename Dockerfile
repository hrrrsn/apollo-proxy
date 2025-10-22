FROM node:22.21.0-slim@sha256:f9f7f95dcf1f007b007c4dcd44ea8f7773f931b71dc79d57c216e731c87a090b
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
