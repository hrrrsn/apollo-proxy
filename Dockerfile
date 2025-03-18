FROM node:22.14.0-slim@sha256:42f4ae5348d19d92cdaffb0cbb7f49fe5c11c990e4a689bc3e49a13a0d49e164
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
