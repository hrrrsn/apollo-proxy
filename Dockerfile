FROM node:22.9.0-slim@sha256:ddd35141c4d266ea6ed7a037892a0c61b5fa415976494977166afaa118cc6b30
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
