FROM node:22.18.0-slim@sha256:88f44fbb06cc98e1451e4e015c122f84030ec55c603f753ed97b889db0bb8d4d
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
