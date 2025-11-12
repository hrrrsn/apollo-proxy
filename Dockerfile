FROM node:24.11.1-slim@sha256:1df475b6befed0f5b06f8c5d806eebd086fbd5944d8511da3957057d5ff74259
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
