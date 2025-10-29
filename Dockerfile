FROM node:24.11.0-slim@sha256:0f2d677a7152ee7ac390837bd4fc36aca12f595411df5d4209f972660e34a7b6
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
