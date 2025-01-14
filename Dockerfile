FROM node:22.13.0-slim@sha256:005e4c1b9ef0007ad2b67beb81a9c99d47216f2dd3902dcc2033b26c122442dc
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
