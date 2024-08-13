FROM node:22.6.0-slim@sha256:a625e6b8f39be6a34c4e9c295d31a8bfa1c461237dde66cad75937c01783f6ce
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
