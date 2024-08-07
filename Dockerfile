FROM node:22.6.0-slim@sha256:a46754b85d2396a0d335916fe6c7405cfa7b349da60129b94e0f76c82a03ba70
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
