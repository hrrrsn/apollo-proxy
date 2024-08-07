FROM node:22.6.0-slim@sha256:0419dfdd085a0e6e52921b8ba952ea8c3317d7e0382a16c63b1d40ce5e8c0cea
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
