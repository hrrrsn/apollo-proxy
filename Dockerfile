FROM node:22.8.0-slim@sha256:4c17e223f2bf76b153fc19e609b7776c0ddba4b4bb8be4f3de231ce291228c1d
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
