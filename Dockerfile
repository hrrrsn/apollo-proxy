FROM node:22.18.0-slim@sha256:35bcdd19215117d71047f9d21a3be301f1cbc733fe06db7a142f5a8469a4a6f1
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
