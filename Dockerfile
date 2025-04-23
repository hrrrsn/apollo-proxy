FROM node:22.15.0-slim@sha256:36c1739a33557d71a5671537a61ed4f88897ef0b99fab718d3f0725609c27ff1
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
