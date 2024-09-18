FROM node:22.9.0-slim@sha256:903eaf1ae555002624d07066b7ce506dc2fb67b6da3121255b40ff4dc8e7e1b8
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
