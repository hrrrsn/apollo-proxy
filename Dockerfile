FROM node:22.9.0-slim@sha256:f837a037e71c7bf7d6d0fe0e5246b7b7339b63c6a4d517ebda4ee097d03d259c
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
