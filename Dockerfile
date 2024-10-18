FROM node:22.10.0-slim@sha256:5f2f5525fe1350569d74785d4bce90f379cbfd5ab17afcb89e0a34988e0849eb
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
