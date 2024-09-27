FROM node:22.9.0-slim@sha256:0f221cbc88c31650c1f509b8f885374f06d6bb1eb40964edbd7ac0433524cd86
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
