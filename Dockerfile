FROM node:22.11.0-slim@sha256:ab1ba25996833ac547afb1dd8d59f4d31bd2b29b5574bf20b07e57cb5726d274
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
