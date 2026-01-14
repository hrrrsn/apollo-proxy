FROM node:24.13.0-slim@sha256:3cb7fee673aae0d0ddb7de47650b3bb6587e5d6abe27734554c06306600f7348
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
