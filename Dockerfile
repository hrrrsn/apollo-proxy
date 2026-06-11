FROM node:24.16.0-slim@sha256:d1006ab709fc360e4f4c4de35eb190af0c2ab939ea5dba19427388405ccdf60f
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
