FROM node:22.13.1-slim@sha256:34d121c93aad04b4b93152216d419d5b3b14c12fedd87aaa8f1d64c827edd817
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
