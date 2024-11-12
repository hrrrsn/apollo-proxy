FROM node:22.11.0-slim@sha256:98cc41633a6854786bcd23ab1cc5460bbed60aed2a97d10a110b4f4206291399
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
