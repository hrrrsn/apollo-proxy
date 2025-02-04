FROM node:22.13.1-slim@sha256:2945d83558df87ea0087972d7c14c752a0dcfe34654b4f67b2798e14d6f6f938
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
