FROM node:22.12.0-slim@sha256:1e3c0d7648ecb3425fc500d3d3abb1b1ff54e324045a898103944cb4eff92451
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
